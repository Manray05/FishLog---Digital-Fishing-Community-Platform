;; FishLog - Digital Fishing Community Platform
;; A blockchain-based platform for fishing logs, catch records,
;; and angler community rewards

;; Contract constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))
(define-constant err-invalid-input (err u104))

;; Token constants
(define-constant token-name "FishLog Angler Token")
(define-constant token-symbol "FLT")
(define-constant token-decimals u6)
(define-constant token-max-supply u42000000000) ;; 42k tokens with 6 decimals

;; Reward amounts (in micro-tokens)
(define-constant reward-catch u1700000) ;; 1.7 FLT
(define-constant reward-spot u2300000) ;; 2.3 FLT
(define-constant reward-milestone u8200000) ;; 8.2 FLT

;; Data variables
(define-data-var total-supply uint u0)
(define-data-var next-spot-id uint u1)
(define-data-var next-catch-id uint u1)

;; Token balances
(define-map token-balances principal uint)

;; Angler profiles
(define-map angler-profiles
  principal
  {
    username: (string-ascii 24),
    fishing-style: (string-ascii 12), ;; "freshwater", "saltwater", "fly-fish", "ice-fish", "mixed"
    total-catches: uint,
    spots-shared: uint,
    biggest-fish: uint, ;; centimeters
    angler-level: uint, ;; 1-5
    join-date: uint
  }
)

;; Fishing spots
(define-map fishing-spots
  uint
  {
    spot-name: (string-ascii 36),
    location: (string-ascii 32),
    water-type: (string-ascii 12), ;; "lake", "river", "ocean", "pond", "stream"
    fish-species: (string-ascii 24),
    access-level: (string-ascii 8), ;; "easy", "moderate", "hard"
    submitter: principal,
    catch-reports: uint,
    average-rating: uint
  }
)

;; Catch records
(define-map catch-records
  uint
  {
    spot-id: uint,
    angler: principal,
    fish-species: (string-ascii 20),
    fish-length: uint, ;; centimeters
    catch-method: (string-ascii 16), ;; "bait", "lure", "fly", "trolling"
    catch-notes: (string-ascii 96),
    catch-date: uint,
    released: bool
  }
)

;; Spot reviews
(define-map spot-reviews
  { spot-id: uint, reviewer: principal }
  {
    rating: uint, ;; 1-10
    review-text: (string-ascii 160),
    fish-activity: (string-ascii 8), ;; "high", "medium", "low"
    review-date: uint,
    useful-votes: uint
  }
)

;; Angler milestones
(define-map angler-milestones
  { angler: principal, milestone: (string-ascii 12) }
  {
    achievement-date: uint,
    catch-count: uint
  }
)

;; Helper function to get or create profile
(define-private (get-or-create-profile (angler principal))
  (match (map-get? angler-profiles angler)
    profile profile
    {
      username: "",
      fishing-style: "freshwater",
      total-catches: u0,
      spots-shared: u0,
      biggest-fish: u0,
      angler-level: u1,
      join-date: stacks-block-height
    }
  )
)

;; Token functions
(define-read-only (get-name)
  (ok token-name)
)

(define-read-only (get-symbol)
  (ok token-symbol)
)

(define-read-only (get-decimals)
  (ok token-decimals)
)

(define-read-only (get-balance (user principal))
  (ok (default-to u0 (map-get? token-balances user)))
)

(define-private (mint-tokens (recipient principal) (amount uint))
  (let (
    (current-balance (default-to u0 (map-get? token-balances recipient)))
    (new-balance (+ current-balance amount))
    (new-total-supply (+ (var-get total-supply) amount))
  )
    (asserts! (<= new-total-supply token-max-supply) err-invalid-input)
    (map-set token-balances recipient new-balance)
    (var-set total-supply new-total-supply)
    (ok amount)
  )
)

;; Add fishing spot
(define-public (add-fishing-spot (spot-name (string-ascii 36)) (location (string-ascii 32)) (water-type (string-ascii 12)) (fish-species (string-ascii 24)) (access-level (string-ascii 8)))
  (let (
    (spot-id (var-get next-spot-id))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len spot-name) u0) err-invalid-input)
    (asserts! (> (len location) u0) err-invalid-input)
    (asserts! (> (len fish-species) u0) err-invalid-input)
    
    (map-set fishing-spots spot-id {
      spot-name: spot-name,
      location: location,
      water-type: water-type,
      fish-species: fish-species,
      access-level: access-level,
      submitter: tx-sender,
      catch-reports: u0,
      average-rating: u0
    })
    
    ;; Update profile
    (map-set angler-profiles tx-sender
      (merge profile {spots-shared: (+ (get spots-shared profile) u1)})
    )
    
    ;; Award spot sharing tokens
    (try! (mint-tokens tx-sender reward-spot))
    
    (var-set next-spot-id (+ spot-id u1))
    (print {action: "fishing-spot-added", spot-id: spot-id, submitter: tx-sender})
    (ok spot-id)
  )
)

;; Log catch record
(define-public (log-catch (spot-id uint) (fish-species (string-ascii 20)) (fish-length uint) (catch-method (string-ascii 16)) (catch-notes (string-ascii 96)) (released bool))
  (let (
    (catch-id (var-get next-catch-id))
    (spot (unwrap! (map-get? fishing-spots spot-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len fish-species) u0) err-invalid-input)
    (asserts! (> fish-length u0) err-invalid-input)
    
    (map-set catch-records catch-id {
      spot-id: spot-id,
      angler: tx-sender,
      fish-species: fish-species,
      fish-length: fish-length,
      catch-method: catch-method,
      catch-notes: catch-notes,
      catch-date: stacks-block-height,
      released: released
    })
    
    ;; Update spot catch reports
    (map-set fishing-spots spot-id
      (merge spot {catch-reports: (+ (get catch-reports spot) u1)})
    )
    
    ;; Update profile
    (let (
      (new-biggest (if (> fish-length (get biggest-fish profile)) fish-length (get biggest-fish profile)))
    )
      (map-set angler-profiles tx-sender
        (merge profile {
          total-catches: (+ (get total-catches profile) u1),
          biggest-fish: new-biggest,
          angler-level: (+ (get angler-level profile) (/ fish-length u50))
        })
      )
    )
    
    ;; Award catch tokens with bonus for big fish
    (let (
      (base-reward reward-catch)
      (big-fish-bonus (if (> fish-length u50) u1000000 u0))
    )
      (try! (mint-tokens tx-sender (+ base-reward big-fish-bonus)))
    )
    
    (var-set next-catch-id (+ catch-id u1))
    (print {action: "catch-logged", catch-id: catch-id, spot-id: spot-id})
    (ok catch-id)
  )
)

;; Review fishing spot
(define-public (write-spot-review (spot-id uint) (rating uint) (review-text (string-ascii 160)) (fish-activity (string-ascii 8)))
  (let (
    (spot (unwrap! (map-get? fishing-spots spot-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (and (>= rating u1) (<= rating u10)) err-invalid-input)
    (asserts! (> (len review-text) u0) err-invalid-input)
    (asserts! (is-none (map-get? spot-reviews {spot-id: spot-id, reviewer: tx-sender})) err-already-exists)
    
    (map-set spot-reviews {spot-id: spot-id, reviewer: tx-sender} {
      rating: rating,
      review-text: review-text,
      fish-activity: fish-activity,
      review-date: stacks-block-height,
      useful-votes: u0
    })
    
    ;; Update spot average rating (simplified calculation)
    (let (
      (current-avg (get average-rating spot))
      (catch-reports (get catch-reports spot))
      (new-avg (if (> catch-reports u0)
                 (/ (+ (* current-avg catch-reports) rating) (+ catch-reports u1))
                 rating))
    )
      (map-set fishing-spots spot-id (merge spot {average-rating: new-avg}))
    )
    
    (print {action: "spot-review-written", spot-id: spot-id, reviewer: tx-sender})
    (ok true)
  )
)

;; Vote review useful
(define-public (vote-useful (spot-id uint) (reviewer principal))
  (let (
    (review (unwrap! (map-get? spot-reviews {spot-id: spot-id, reviewer: reviewer}) err-not-found))
  )
    (asserts! (not (is-eq tx-sender reviewer)) err-unauthorized)
    
    (map-set spot-reviews {spot-id: spot-id, reviewer: reviewer}
      (merge review {useful-votes: (+ (get useful-votes review) u1)})
    )
    
    (print {action: "review-voted-useful", spot-id: spot-id, reviewer: reviewer})
    (ok true)
  )
)

;; Update fishing style
(define-public (update-fishing-style (new-fishing-style (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-fishing-style) u0) err-invalid-input)
    
    (map-set angler-profiles tx-sender (merge profile {fishing-style: new-fishing-style}))
    
    (print {action: "fishing-style-updated", angler: tx-sender, style: new-fishing-style})
    (ok true)
  )
)

;; Claim milestone
(define-public (claim-milestone (milestone (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (is-none (map-get? angler-milestones {angler: tx-sender, milestone: milestone})) err-already-exists)
    
    ;; Check milestone requirements
    (let (
      (milestone-met
        (if (is-eq milestone "angler-30") (>= (get total-catches profile) u30)
        (if (is-eq milestone "guide-5") (>= (get spots-shared profile) u5)
        false)))
    )
      (asserts! milestone-met err-unauthorized)
      
      ;; Record milestone
      (map-set angler-milestones {angler: tx-sender, milestone: milestone} {
        achievement-date: stacks-block-height,
        catch-count: (get total-catches profile)
      })
      
      ;; Award milestone tokens
      (try! (mint-tokens tx-sender reward-milestone))
      
      (print {action: "milestone-claimed", angler: tx-sender, milestone: milestone})
      (ok true)
    )
  )
)

;; Update username
(define-public (update-username (new-username (string-ascii 24)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-username) u0) err-invalid-input)
    (map-set angler-profiles tx-sender (merge profile {username: new-username}))
    (print {action: "username-updated", angler: tx-sender})
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-angler-profile (angler principal))
  (map-get? angler-profiles angler)
)

(define-read-only (get-fishing-spot (spot-id uint))
  (map-get? fishing-spots spot-id)
)

(define-read-only (get-catch-record (catch-id uint))
  (map-get? catch-records catch-id)
)

(define-read-only (get-spot-review (spot-id uint) (reviewer principal))
  (map-get? spot-reviews {spot-id: spot-id, reviewer: reviewer})
)

(define-read-only (get-milestone (angler principal) (milestone (string-ascii 12)))
  (map-get? angler-milestones {angler: angler, milestone: milestone})
)