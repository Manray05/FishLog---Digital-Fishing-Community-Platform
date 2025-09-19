# FishLog - Digital Fishing Community Platform

A blockchain-based platform for fishing logs, catch records, and angler community rewards built on the Stacks blockchain using Clarity smart contracts.

[![Built with Stacks](https://img.shields.io/badge/Built_with-Stacks-purple.svg)](https://www.stacks.co/)
[![Smart Contract](https://img.shields.io/badge/Smart_Contract-Clarity-orange.svg)](https://clarity-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

FishLog creates a decentralized community where anglers can document fishing experiences, share productive fishing spots, record catch data, and earn FLT (FishLog Angler Token) rewards for contributing to the fishing community knowledge base. The platform emphasizes responsible fishing practices, conservation awareness, and community-driven spot discovery.

## Key Features

### Comprehensive Fishing Documentation
- **Detailed Catch Logging**: Record fish species, length measurements, catch methods, and fishing notes
- **Fishing Spot Database**: Community-contributed locations with water type, species, and access information
- **Conservation Tracking**: Release status documentation promoting catch-and-release practices
- **Method Documentation**: Bait, lure, fly fishing, and trolling technique tracking
- **Personal Fishing History**: Complete angling record with biggest fish and total catches

### Community Spot Sharing
- **Location Discovery**: Share productive fishing spots with detailed access and species information
- **Water Type Classification**: Lake, river, ocean, pond, and stream categorization
- **Access Level Rating**: Easy, moderate, and hard accessibility assessment for planning
- **Species Information**: Target fish species documentation for location planning
- **Community Validation**: Catch reports and ratings confirming spot quality

### Angler Community Features
- **Spot Reviews**: Rate and review fishing locations with activity levels and detailed feedback
- **Fishing Style Specialization**: Freshwater, saltwater, fly fishing, ice fishing, and mixed approaches
- **Community Knowledge**: Useful vote system for helpful reviews and fishing information
- **Achievement Recognition**: Milestones for consistent fishing and community contribution

### Conservation-Minded Design
- **Release Documentation**: Track catch-and-release practices supporting fish population health
- **Responsible Spot Sharing**: Community-driven location sharing with conservation awareness
- **Sustainable Fishing Culture**: Platform features promoting long-term fishing resource preservation
- **Educational Component**: Community reviews and documentation sharing fishing knowledge

## Token Economy (FLT - FishLog Angler Token)

### Token Details
- **Name**: FishLog Angler Token
- **Symbol**: FLT
- **Decimals**: 6
- **Total Supply**: 42,000 FLT
- **Blockchain**: Stacks

### Reward Structure
![FishLog Reward Structure](images/fishlog-reward-structure.png)

## Smart Contract Architecture

### Core Data Structures

#### Angler Profile
![Angler Profile Structure](images/angler-profile-structure.png)

#### Fishing Spot
![Fishing Spot Structure](images/fishing-spot-structure.png)

#### Catch Record
![Catch Record Structure](images/catch-record-structure.png)

#### Spot Review System
![Spot Review Structure](images/spot-review-structure.png)

### Fishing Style Categories

The platform supports various angling approaches and specializations:

- **Freshwater**: Lakes, rivers, and streams with species like bass, trout, and pike
- **Saltwater**: Ocean and coastal fishing for species like tuna, marlin, and snapper
- **Fly Fishing**: Specialized technique focusing on presentation and casting skill
- **Ice Fishing**: Winter angling through ice with unique equipment and methods
- **Mixed**: Multi-environment fishing combining various techniques and locations

### Water Body Classifications

Comprehensive location categorization for fishing planning:

| Water Type | Description | Typical Species |
|------------|-------------|-----------------|
| Lake | Large freshwater bodies | Bass, walleye, pike, trout |
| River | Flowing freshwater systems | Trout, salmon, catfish |
| Ocean | Saltwater coastal and offshore | Tuna, marlin, cod, flounder |
| Pond | Small freshwater bodies | Bluegill, bass, catfish |
| Stream | Small flowing water | Trout, small bass |

## Getting Started

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks smart contract development tool
- [Stacks Wallet](https://www.hiro.so/wallet) - For blockchain interactions
- Understanding of fishing practices and conservation principles
- Knowledge of Clarity smart contracts

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/fishlog-platform.git
cd fishlog-platform
```

2. **Install Clarinet**
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.8.0/clarinet-linux-x64.tar.gz | tar xz
mv clarinet /usr/local/bin/
```

3. **Initialize project**
```bash
clarinet new fishlog-project
cd fishlog-project
# Copy contract to contracts/fishlog.clar
```

### Deployment

1. **Test the contract**
```bash
clarinet test
```

2. **Deploy to devnet**
```bash
clarinet integrate
```

3. **Deploy to testnet/mainnet**
```bash
clarinet deployment apply -p testnet
```

## Usage Examples

### Add Fishing Spot
![Add Fishing Spot Function](images/add-fishing-spot-function.png)

### Log Catch Record
![Log Catch Function](images/log-catch-function.png)

### Write Spot Review
![Write Spot Review Function](images/write-spot-review-function.png)

### Vote Review Useful
![Vote Useful Function](images/vote-useful-function.png)

### Update Fishing Style
![Update Fishing Style Function](images/update-fishing-style-function.png)

### Claim Achievement Milestone
![Claim Milestone Function](images/claim-milestone-function.png)

## Core Functions

### Spot Management
- `add-fishing-spot(...)` - Share productive fishing locations with community
- `get-fishing-spot(spot-id)` - Retrieve location details and community ratings
- `write-spot-review(...)` - Submit feedback and ratings for fishing spots
- `vote-useful(...)` - Appreciate helpful community reviews and information

### Catch Tracking
- `log-catch(...)` - Record fishing results with species and method details
- `get-catch-record(catch-id)` - View individual catch details and notes
- `update-fishing-style(style)` - Update angling specialization and preferences

### Community Features
- `claim-milestone(milestone)` - Unlock achievement rewards for dedication
- `update-username(username)` - Update angler profile information
- `get-angler-profile(angler)` - View fishing statistics and achievements

### Token Operations
- `get-balance(user)` - Check FLT token balance
- `get-name()`, `get-symbol()`, `get-decimals()` - Token metadata

## Fishing Documentation Features

### Catch Record Tracking
- **Species Identification**: Detailed fish species documentation for biodiversity awareness
- **Measurement Recording**: Length in centimeters for growth and population data
- **Method Documentation**: Fishing technique tracking for skill development and education
- **Release Status**: Conservation-focused catch-and-release documentation
- **Fishing Notes**: Personal observations and conditions for future reference

### Spot Information System
- **Location Details**: Geographic information with access level assessment
- **Species Targeting**: Expected fish species for trip planning and preparation
- **Activity Levels**: Community-reported fish activity for optimal timing
- **Accessibility Rating**: Physical access difficulty for appropriate preparation
- **Community Validation**: Catch reports confirming spot productivity and quality

### Conservation Integration
- **Release Tracking**: Catch-and-release documentation supporting fish population health
- **Responsible Sharing**: Community spot sharing with conservation awareness
- **Educational Reviews**: Fishing knowledge sharing through detailed spot feedback
- **Sustainable Practices**: Platform features encouraging long-term resource preservation

## Angler Progression System

### Skill Development
- **Angler Level**: Progressive 1-5 scale based on fishing experience and catch size
- **Biggest Fish**: Personal record tracking encouraging skill improvement
- **Total Catches**: Cumulative fishing success measurement
- **Style Specialization**: Focused expertise in specific fishing approaches

### Achievement Milestones
![Achievement Milestones](images/achievement-milestones-fishlog.png)

### Community Recognition
- **Spot Discovery**: Recognition for sharing productive fishing locations
- **Knowledge Sharing**: Appreciation for helpful reviews and fishing information
- **Conservation Leadership**: Community acknowledgment of responsible fishing practices
- **Experience Documentation**: Platform contribution through detailed catch logging

## Access Controls & Requirements

### Spot Sharing
- Location name and species information required for community value
- Water type and access level specification for planning assistance
- Community-driven spot discovery encouraging exploration

### Catch Logging
- Fish species and length measurement required for data integrity
- Catch method documentation for educational and skill development
- Release status tracking promoting conservation awareness

### Review System
- One review per spot per angler ensuring diverse perspectives
- Rating scale validation (1-10) for consistent feedback
- Community useful voting for review quality assessment

## Security Features

### Fishing Data Integrity
- Length measurement validation ensuring realistic catch records
- Species name requirements preventing incomplete documentation
- Method specification for authentic fishing technique tracking
- Release status documentation for conservation accountability

### Input Validation
- String length limits appropriate for fishing terminology and descriptions
- Numeric range checking for measurements and ratings
- Required field validation for complete fishing documentation
- Access level validation for accurate difficulty assessment

### Access Control
- Personal catch logging restricted to individual anglers
- Self-voting prevention for useful review voting
- Spot review restrictions ensuring objective community feedback
- Profile updates limited to account owners

### Error Handling
![FishLog Error Codes](images/fishlog-error-codes.png)

## Fishing Community Features

### Knowledge Sharing
- **Technique Documentation**: Catch method tracking for skill sharing and education
- **Location Intelligence**: Spot characteristics and species information for trip planning
- **Seasonal Patterns**: Catch timing and conditions for improved fishing success
- **Equipment Insights**: Method-specific information supporting equipment decisions

### Conservation Culture
- **Catch-and-Release Promotion**: Release status tracking encouraging fish population preservation
- **Responsible Spot Sharing**: Community location discovery with conservation awareness
- **Educational Reviews**: Fishing knowledge sharing supporting sustainable practices
- **Long-term Resource Preservation**: Platform features promoting fishing sustainability

### Community Learning
- **Species Education**: Fish identification and characteristics through catch documentation
- **Access Information**: Spot accessibility and preparation requirements for safety
- **Method Instruction**: Fishing technique sharing through detailed catch records
- **Local Knowledge**: Community-driven information about specific locations and conditions

## Development Roadmap

### Phase 1: Core Fishing Platform
- Smart contract deployment with comprehensive catch logging and spot sharing
- Community review system encouraging helpful fishing information exchange
- Angler progression system recognizing fishing experience and community contribution
- Token reward distribution promoting platform participation and knowledge sharing

### Phase 2: Enhanced Community Features
- Photo integration for catch verification and spot documentation
- Weather integration with fishing condition correlation and planning
- Tide and lunar calendar integration for optimal fishing timing
- Mobile application for real-time catch logging and spot discovery

### Phase 3: Conservation & Education
- Partnership with conservation organizations for habitat protection initiatives
- Educational content integration with species information and regulations
- Citizen science integration contributing catch data to fisheries research
- Tournament and event organization tools for community fishing activities

### Phase 4: Advanced Analytics
- Catch pattern analysis and fishing success prediction algorithms
- Species population monitoring through community catch documentation
- Climate impact tracking on fishing patterns and species distribution
- Advanced community features with mentorship and guided fishing programs

## Conservation & Responsibility

### Sustainable Fishing Practices
- Emphasis on catch-and-release documentation promoting fish population health
- Community education through fishing knowledge sharing and conservation awareness
- Responsible spot sharing considering environmental impact and access sustainability
- Support for fishing regulations and conservation initiatives

### Environmental Stewardship
- Long-term fishing resource preservation through community responsibility
- Habitat protection awareness through educational community reviews
- Species conservation support through release tracking and population awareness
- Climate change impact recognition on fishing patterns and species health

### Community Standards
- Respectful fishing location sharing with consideration for local regulations and access
- Accurate catch documentation supporting community knowledge and conservation research
- Constructive review feedback focused on fishing success and conservation awareness
- Support for beginning anglers learning responsible fishing practices and techniques

## Testing

```bash
# Run comprehensive tests
clarinet test

# Test specific fishing modules
clarinet test tests/spot_management_test.ts
clarinet test tests/catch_logging_test.ts
clarinet test tests/community_features_test.ts
clarinet test tests/conservation_tracking_test.ts

# Validate contract
clarinet check
```

## API Reference

### Read-Only Functions
- `get-angler-profile(angler)` - Angler statistics and fishing achievements
- `get-fishing-spot(spot-id)` - Spot details and community ratings
- `get-catch-record(catch-id)` - Individual catch data and conservation status
- `get-spot-review(spot-id, reviewer)` - Review content and community feedback
- `get-milestone(angler, milestone)` - Achievement status and completion dates

### Write Functions
- Fishing spot discovery and sharing functions
- Catch logging and conservation tracking functions
- Community review and feedback functions
- Profile and specialization management functions
- Achievement milestone claiming functions

## Contributing

We welcome contributions from anglers, conservation advocates, fishing guides, and developers!

### Development Guidelines
1. Fork the repository and create feature branches
2. Write comprehensive tests for fishing and conservation scenarios
3. Follow fishing terminology and conservation best practices
4. Update documentation with fishing context and conservation awareness
5. Submit pull requests with detailed fishing use case descriptions

### Contribution Areas
- Fishing-specific smart contract enhancements
- Mobile fishing logging and spot discovery applications
- Conservation tracking and education features
- Community feedback and review system improvements
- Fishing analytics and pattern recognition tools

## Community Standards

### Responsible Fishing Culture
- Emphasis on conservation and sustainable fishing practices in all platform interactions
- Accurate catch documentation supporting community knowledge and fisheries research
- Respectful spot sharing considering environmental impact and access sustainability
- Support for fishing regulations and conservation initiatives

### Conservation Leadership
- Promotion of catch-and-release practices through platform features and community recognition
- Environmental stewardship in fishing location sharing and community education
- Species conservation awareness through documentation and community learning
- Long-term fishing resource preservation through responsible community practices

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Community

- **Documentation**: [docs.fishlog.io](https://docs.fishlog.io)
- **Discord**: [Join our angling community](https://discord.gg/fishlog)
- **Twitter**: [@FishLogPlatform](https://twitter.com/fishlogplatform)
- **Email**: support@fishlog.io

## Acknowledgments

- Built on Stacks blockchain infrastructure
- Powered by Clarity smart contract language
- Inspired by the global fishing community and conservation movement
- Dedicated to sustainable fishing practices and habitat preservation
- Community-driven development with angler and conservation expert guidance

---

**Logging catches, sharing spots, preserving waters**
