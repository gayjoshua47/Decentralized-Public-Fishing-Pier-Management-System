# Decentralized Public Fishing Pier Management System

A comprehensive blockchain-based system for managing public fishing pier operations, built on the Stacks blockchain using Clarity smart contracts.

## System Overview

This system consists of five interconnected smart contracts that manage different aspects of a public fishing pier:

### 1. Fishing License Verification Contract (`fishing-license.clar`)
- Validates angler permits and fishing licenses
- Tracks license expiration dates and types
- Enforces fishing regulations and limits
- Manages license renewals and suspensions

### 2. Maintenance Scheduling Contract (`maintenance-scheduling.clar`)
- Coordinates pier repairs and safety inspections
- Schedules routine maintenance tasks
- Tracks maintenance history and costs
- Manages contractor assignments

### 3. Bait Shop Operations Contract (`bait-shop.clar`)
- Manages tackle sales and equipment rentals
- Tracks inventory and pricing
- Handles customer transactions
- Manages rental equipment returns

### 4. Fish Cleaning Station Contract (`fish-cleaning.clar`)
- Maintains cleaning facility reservations
- Manages waste disposal tracking
- Handles station availability and scheduling
- Tracks usage fees and maintenance needs

### 5. Tournament Coordination Contract (`tournament-coordination.clar`)
- Organizes fishing competitions and events
- Manages participant registration and fees
- Handles prize distribution
- Tracks tournament results and rankings

## Key Features

- **Decentralized Management**: No single point of failure
- **Transparent Operations**: All transactions recorded on blockchain
- **Automated Compliance**: Smart contract enforcement of rules
- **Real-time Tracking**: Live status updates for all pier operations
- **Community Governance**: Stakeholder participation in decision making

## Technical Architecture

### Data Types
- **Principal**: User addresses and contract identifiers
- **Uint**: Numeric values for IDs, amounts, timestamps
- **String-ascii**: Text data for names, descriptions
- **Bool**: Status flags and permissions
- **Optional**: Nullable values for flexible data handling

### Error Handling
Each contract implements comprehensive error codes for:
- Permission violations
- Invalid input validation
- Resource availability conflicts
- Payment processing failures

### Security Features
- Role-based access control
- Input validation and sanitization
- Reentrancy protection
- Emergency pause functionality

## Getting Started

### Prerequisites
- Clarinet CLI installed
- Node.js and npm
- Stacks wallet for testing

### Installation

1. Clone the repository
2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

4. Deploy contracts:
   \`\`\`bash
   clarinet deploy
   \`\`\`

## Usage Examples

### License Verification
\`\`\`clarity
;; Register a new fishing license
(contract-call? .fishing-license register-license
"John Doe"
u365
"recreational")
\`\`\`

### Schedule Maintenance
\`\`\`clarity
;; Schedule pier inspection
(contract-call? .maintenance-scheduling schedule-maintenance
"Safety Inspection"
u1640995200
u500)
\`\`\`

### Rent Equipment
\`\`\`clarity
;; Rent fishing rod
(contract-call? .bait-shop rent-equipment
"fishing-rod-premium"
u4)
\`\`\`

## Testing

The system includes comprehensive test suites using Vitest:

- Unit tests for each contract function
- Integration tests for cross-contract interactions
- Edge case testing for error conditions
- Performance testing for high-load scenarios

Run tests with:
\`\`\`bash
npm test
\`\`\`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

For questions or issues, please open a GitHub issue or contact the development team.
