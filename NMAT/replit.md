# NMAT - Country-Based CPA Rewards Platform

## Overview

NMAT is a country-based CPA (Cost Per Action) rewards platform where users earn USDT by completing offers/tasks. The platform is built with a React frontend and Express backend, using PostgreSQL for data persistence. Key features include:

- **Country-based task system**: Users see only tasks assigned to their country
- **Smart link integration**: Tasks redirect to OGAds smart links, with completion verified via postback
- **Referral system**: Users earn rewards for referring others, with country-specific commission rates
- **Withdrawal system**: Users can withdraw earnings in USDT (TRC20/ERC20)
- **Admin portal**: Manage users, tasks, withdrawals, announcements, and referral settings

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React 18 with TypeScript
- **Routing**: Wouter (lightweight client-side routing)
- **State Management**: TanStack React Query for server state caching and synchronization
- **UI Components**: shadcn/ui component library built on Radix UI primitives
- **Styling**: Tailwind CSS with custom theme configuration supporting light/dark modes
- **Form Handling**: React Hook Form with Zod validation
- **Build Tool**: Vite for development and production builds

### Backend Architecture
- **Framework**: Express.js with TypeScript
- **Authentication**: Passport.js with local strategy, session-based authentication
- **Session Storage**: Express-session (memory store in dev, connect-pg-simple available for production)
- **API Pattern**: REST endpoints defined in a shared route contract (`shared/routes.ts`) using Zod schemas for type-safe request/response validation

### Data Storage
- **Database**: PostgreSQL with Drizzle ORM
- **Schema Location**: `shared/schema.ts` - defines users, tasks, completedTasks, withdrawals, announcements, referrals, and referralSettings tables
- **Migrations**: Drizzle-kit for schema pushes (`npm run db:push`)

### Key Design Patterns
- **Monorepo Structure**: Client code in `client/`, server in `server/`, shared types/schemas in `shared/`
- **Type-safe API Contract**: `shared/routes.ts` defines all API endpoints with Zod schemas, ensuring frontend and backend stay synchronized
- **Storage Abstraction**: `server/storage.ts` provides a database access layer implementing `IStorage` interface
- **Path Aliases**: `@/` for client source, `@shared/` for shared code

### Security Considerations
- Passwords are hashed using SHA256 (should upgrade to bcrypt/argon2 for production)
- Session-based authentication with secure cookies in production
- Role-based access control (user/admin roles)
- Tasks filtered by user's country on the backend

## External Dependencies

### Database
- **PostgreSQL**: Primary database, connection via `DATABASE_URL` environment variable

### Third-Party Services
- **OGAds**: CPA network integration via smart links and postback system for task completion verification

### Key NPM Packages
- **drizzle-orm/drizzle-kit**: Database ORM and migration tooling
- **passport/passport-local**: Authentication framework
- **express-session/connect-pg-simple**: Session management
- **@tanstack/react-query**: Server state management
- **@radix-ui/***: Accessible UI component primitives
- **zod/drizzle-zod**: Schema validation and type generation
- **date-fns**: Date formatting utilities
- **recharts**: Dashboard analytics charts