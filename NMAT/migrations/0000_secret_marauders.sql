CREATE TABLE "announcements" (
	"id" serial PRIMARY KEY NOT NULL,
	"content" text NOT NULL,
	"country" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "completed_tasks" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"task_id" integer NOT NULL,
	"transaction_id" text,
	"reward_earned" numeric(10, 2) NOT NULL,
	"completed_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "referral_settings" (
	"id" serial PRIMARY KEY NOT NULL,
	"country" text NOT NULL,
	"reward_amount" numeric(10, 2) NOT NULL,
	"min_withdrawal" numeric(10, 2) DEFAULT '20' NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "referral_settings_country_unique" UNIQUE("country")
);
--> statement-breakpoint
CREATE TABLE "referrals" (
	"id" serial PRIMARY KEY NOT NULL,
	"referrer_id" integer NOT NULL,
	"referred_user_id" integer NOT NULL,
	"country" text NOT NULL,
	"reward" numeric(10, 2) DEFAULT '0' NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "tasks" (
	"id" serial PRIMARY KEY NOT NULL,
	"country" text NOT NULL,
	"smart_link" text NOT NULL,
	"tag_name" text NOT NULL,
	"reward_amount" numeric(10, 2) NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" serial PRIMARY KEY NOT NULL,
	"username" text NOT NULL,
	"email" text NOT NULL,
	"password" text NOT NULL,
	"country" text NOT NULL,
	"phone" text NOT NULL,
	"referral_code" text NOT NULL,
	"referred_by" integer,
	"balance_task" numeric(10, 2) DEFAULT '0' NOT NULL,
	"balance_referral" numeric(10, 2) DEFAULT '0' NOT NULL,
	"role" text DEFAULT 'user' NOT NULL,
	"ip_address" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "users_username_unique" UNIQUE("username"),
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_referral_code_unique" UNIQUE("referral_code")
);
--> statement-breakpoint
CREATE TABLE "withdrawals" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" integer NOT NULL,
	"amount" numeric(10, 2) NOT NULL,
	"wallet_address" text NOT NULL,
	"network" text NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX "unq_user_task" ON "completed_tasks" USING btree ("user_id","task_id");