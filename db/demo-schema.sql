CREATE TYPE "public"."approval_status" AS ENUM('approved', 'not_approved', 'cancelled', 'transferred');
CREATE TYPE "public"."employee_role" AS ENUM('doer', 'initiator', 'both');
CREATE TYPE "public"."task_priority" AS ENUM('imp_urgent', 'imp_not_urgent', 'not_imp_urgent', 'not_imp_not_urgent');
CREATE TYPE "public"."task_status" AS ENUM('dont_know', 'not_started', 'initiated', 'follow_up', 'need_help', 'on_hold', 'need_info', 'follow_up_1', 'follow_up_2', 'follow_up_3', 'done', 'approved', 'not_approved', 'cancelled', 'transferred');
CREATE TABLE "accounts_bank_balances" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"week_id" uuid NOT NULL,
	"balance" numeric(16, 2),
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_bank_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity" text NOT NULL,
	"target_balance" numeric(16, 2),
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_bank_weeks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"label" text NOT NULL,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_cash_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity" text,
	"name_on_cheque" text,
	"cheque_no" text,
	"chq_date" text,
	"amount" numeric(14, 2),
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_cash_limits" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity" text NOT NULL,
	"max_allowed" numeric(14, 2),
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_cash_months" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"month" integer NOT NULL,
	"amount" numeric(14, 2),
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_cc_cards" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity_name" text,
	"card_name" text NOT NULL,
	"ecs" text,
	"ecs_from" text,
	"stmt_period" text,
	"stmt_start_day" text,
	"due_day" text,
	"soft_copy_auto_email" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_cc_months" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"card_id" uuid NOT NULL,
	"month" integer NOT NULL,
	"hard_copy" text,
	"google_drive" text,
	"tally_entry" text,
	"balance_tally" text,
	"cc_paid_date" text,
	"cc_paid_amt" text,
	"int_fin_chgs" text,
	"chg_reversed" text,
	"notes" text,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_due_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text,
	"area" text,
	"compliance" text NOT NULL,
	"frequency" text,
	"ecs" text,
	"ecs_from" text,
	"statement_period" text,
	"statement_date" text,
	"due_date" text,
	"soft_copy_auto_email" text,
	"hard_copy" text,
	"soft_copy" text,
	"tally_entry" text,
	"balance_tally" text,
	"paid_date" text,
	"paid_amt" text,
	"int_fin_chgs" text,
	"chg_reversed" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_fno_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity" text,
	"agency" text NOT NULL,
	"capital" numeric(16, 2),
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_fno_months" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"month" integer NOT NULL,
	"amount" numeric(14, 2),
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_it_folders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"entity" text NOT NULL,
	"fy" text,
	"folder_link" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_loan_cells" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"loan_id" uuid NOT NULL,
	"period_id" uuid NOT NULL,
	"emi" numeric(16, 2),
	"closing_balance" numeric(18, 2),
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_loan_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text,
	"entity" text,
	"loan_name" text NOT NULL,
	"location" text,
	"emi_date" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_loan_periods" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"label" text NOT NULL,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_lookups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"kind" text NOT NULL,
	"value" text NOT NULL,
	"active" boolean DEFAULT true NOT NULL,
	"sort_order" integer,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_monthly_checks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"fy_start_year" integer NOT NULL,
	"month" integer NOT NULL,
	"status" text NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_monthly_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text,
	"title" text NOT NULL,
	"responsible_person" text,
	"deadline" text,
	"type" text,
	"accounts_notes" text,
	"manan_notes" text,
	"file_link" text,
	"frequency" text,
	"due_month" integer,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_screenshots" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sr_no" integer,
	"project_name" text,
	"project_details" text,
	"frequency" text,
	"target_date" date,
	"actual_date" date,
	"gear" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_shares" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text,
	"entity" text,
	"company" text NOT NULL,
	"folio_demat" text,
	"qty" numeric(18, 4),
	"rate" numeric(16, 4),
	"value" numeric(18, 2),
	"txn_date" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_sip_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy_start_year" integer NOT NULL,
	"code" text,
	"entity" text,
	"fund_name" text NOT NULL,
	"location" text,
	"sip_date" text,
	"type" text,
	"amount" numeric(14, 2),
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_sip_months" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"month" integer NOT NULL,
	"amount" numeric(14, 2),
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_task_list" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sr_no" integer,
	"area" text,
	"task_description" text,
	"status" text DEFAULT 'Pending' NOT NULL,
	"links" text,
	"target_date" date,
	"actual_date" date,
	"gear" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_vasa_balances" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"party" text,
	"direction" text,
	"counterparty" text,
	"amount" numeric(16, 2),
	"as_on" text,
	"notes" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_weekly_checks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"period_year" integer NOT NULL,
	"period_month" integer NOT NULL,
	"week_no" integer NOT NULL,
	"status" text NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "accounts_weekly_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" text,
	"title" text NOT NULL,
	"deadline" text,
	"category" text,
	"responsible_person" text,
	"accounts_notes" text,
	"manan_notes" text,
	"file_link" text,
	"frequency" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "achievements_earned" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"achievement_key" text NOT NULL,
	"earned_at" timestamp with time zone DEFAULT now() NOT NULL,
	"progress" jsonb
);

CREATE TABLE "agreements" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"type" text NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"title" text NOT NULL,
	"entity" text,
	"field_values" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"pdf_path" text,
	"signed_pdf_path" text,
	"signed_name" text,
	"signed_at" timestamp with time zone,
	"signed_ip" text,
	"sign_token" text NOT NULL,
	"created_by_id" uuid,
	"sent_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "ai_usage" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid,
	"feature" text NOT NULL,
	"model" text NOT NULL,
	"input_tokens" integer DEFAULT 0 NOT NULL,
	"output_tokens" integer DEFAULT 0 NOT NULL,
	"cost_estimate" numeric(14, 2) DEFAULT '0' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_activities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ambassador_id" uuid NOT NULL,
	"referral_id" uuid,
	"type" text NOT NULL,
	"title" text,
	"body" text,
	"occurred_at" timestamp with time zone DEFAULT now() NOT NULL,
	"remind_at" timestamp with time zone,
	"done" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_ambassador_products" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ambassador_id" uuid NOT NULL,
	"product_id" uuid NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_ambassadors" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"company" text,
	"email" text,
	"phone" text,
	"photo_url" text,
	"owner_id" uuid,
	"status" text DEFAULT 'active' NOT NULL,
	"tier" text,
	"partner_score" numeric(6, 2),
	"score_updated_at" timestamp with time zone,
	"payout_type" text DEFAULT 'percent' NOT NULL,
	"payout_value" numeric(14, 2) DEFAULT '0' NOT NULL,
	"payout_terms_notes" text,
	"monthly_target" numeric(14, 2),
	"monthly_target_count" integer,
	"joined_on" date,
	"source" text,
	"ai_summary" text,
	"ai_summary_at" timestamp with time zone,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_documents" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ambassador_id" uuid NOT NULL,
	"name" text NOT NULL,
	"version" integer DEFAULT 1 NOT NULL,
	"storage_key" text NOT NULL,
	"mime" text,
	"size_bytes" bigint,
	"supersedes_id" uuid,
	"uploaded_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_payout_referrals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"payout_id" uuid NOT NULL,
	"referral_id" uuid NOT NULL,
	"amount_applied" numeric(14, 2) NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_payouts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ambassador_id" uuid NOT NULL,
	"amount" numeric(14, 2) NOT NULL,
	"paid_on" date DEFAULT now() NOT NULL,
	"method" text,
	"reference" text,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_products" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "amb_referrals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ambassador_id" uuid NOT NULL,
	"prospect_name" text NOT NULL,
	"prospect_company" text,
	"prospect_phone" text,
	"prospect_email" text,
	"prospect_notes" text,
	"received_on" date DEFAULT now() NOT NULL,
	"stage" text DEFAULT 'received' NOT NULL,
	"assigned_to_id" uuid,
	"product_id" uuid,
	"deal_amount" numeric(14, 2),
	"outcome" text DEFAULT 'open' NOT NULL,
	"expected_close" date,
	"won_at" timestamp with time zone,
	"lost_reason" text,
	"commission_amount" numeric(14, 2),
	"commission_basis" text,
	"commission_status" text DEFAULT 'pending' NOT NULL,
	"client_id" uuid,
	"pg_introduction_id" uuid,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appr_attitude" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"key" text NOT NULL,
	"label" text,
	"weight" integer DEFAULT 5 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appr_config" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"manager_id" uuid,
	"management_id" uuid,
	"role_class" text DEFAULT 'non-manager' NOT NULL,
	"dimension_weights" jsonb DEFAULT '{"kpi":20,"goals":30,"culture":15,"problemSolving":10,"growthMindset":10,"attendTraining":5,"skillUpgrade":5,"teamPlayer":5}'::jsonb NOT NULL,
	"incentive_target" numeric(14, 2),
	"knowledge_do" integer DEFAULT 1 NOT NULL,
	"knowledge_give" integer DEFAULT 1 NOT NULL,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "appr_config_employee_id_unique" UNIQUE("employee_id")
);

CREATE TABLE "appr_dimension_score" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"dimension_key" text NOT NULL,
	"self_score" integer,
	"self_note" text,
	"manager_score" integer,
	"manager_note" text,
	"management_score" integer,
	"management_note" text,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appr_item_score" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"item_kind" text NOT NULL,
	"item_id" uuid NOT NULL,
	"actual" text,
	"evidence_url" text,
	"approved" boolean,
	"remarks" text,
	"self_score" integer,
	"self_note" text,
	"manager_score" integer,
	"manager_note" text,
	"management_score" integer,
	"management_note" text,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appr_kpi" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"sr_no" integer,
	"area" text,
	"measure" text,
	"sub_weight" integer DEFAULT 20 NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appr_scorecard" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"incentive_score" integer,
	"incentive_note" text,
	"culture_score" integer,
	"kpi_actuals" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"status" text DEFAULT 'in_progress' NOT NULL,
	"finalized_at" timestamp with time zone,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "appr_scorecard_employee_id_unique" UNIQUE("employee_id")
);

CREATE TABLE "appr_skill" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"name" text,
	"technical" boolean DEFAULT false NOT NULL,
	"sub_weight" integer DEFAULT 33 NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_attachments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"stage" text DEFAULT 'self' NOT NULL,
	"uploaded_by_id" uuid,
	"storage_path" text NOT NULL,
	"file_name" text NOT NULL,
	"mime_type" text,
	"size_bytes" bigint,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_config" (
	"id" text PRIMARY KEY DEFAULT 'default' NOT NULL,
	"dimension_weights" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"rating_terms" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"incentive_target_pct" numeric(6, 2) DEFAULT '20' NOT NULL,
	"knowledge_sharing_rule" jsonb DEFAULT '{"do":6,"give":4}'::jsonb NOT NULL,
	"culture_per_month" integer DEFAULT 3 NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_culture_assignments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"period" text NOT NULL,
	"para_id" uuid NOT NULL,
	"serial" integer NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_cycles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"period" text NOT NULL,
	"label" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"opens_on" date,
	"closes_on" date,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"cycle_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"dimension" text NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"area" text,
	"title" text NOT NULL,
	"measure" text,
	"sub_weight" numeric(6, 2) DEFAULT '0' NOT NULL,
	"is_technical" boolean,
	"is_manager_only" boolean DEFAULT false NOT NULL,
	"is_auto" boolean DEFAULT false NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"actual_value" text,
	"evidence" text,
	"admin_approved" boolean,
	"admin_remarks" text,
	"meta" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "appraisal_scores" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"self_score" numeric(6, 2),
	"self_justification" text,
	"self_submitted_at" timestamp with time zone,
	"manager_id" uuid,
	"manager_score" numeric(6, 2),
	"manager_explanation" text,
	"manager_submitted_at" timestamp with time zone,
	"management_id" uuid,
	"management_score" numeric(6, 2),
	"management_explanation" text,
	"management_submitted_at" timestamp with time zone,
	"max_score" numeric(6, 2),
	"final_score" numeric(6, 2),
	"finalized_by_id" uuid,
	"finalized_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "approval_tokens" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"token_hash" text NOT NULL,
	"kind" text NOT NULL,
	"target_id" text NOT NULL,
	"action" text NOT NULL,
	"created_by_id" uuid,
	"expires_at" timestamp with time zone NOT NULL,
	"used_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "approval_tokens_token_hash_unique" UNIQUE("token_hash")
);

CREATE TABLE "attendance_discipline_notes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"month" text NOT NULL,
	"note" text,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "attendance_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"log_date" date NOT NULL,
	"kind" text NOT NULL,
	"logged_at" timestamp with time zone DEFAULT now() NOT NULL,
	"note" text,
	"lat" double precision,
	"lng" double precision,
	"accuracy_m" real,
	"distance_m" real,
	"verify_method" text DEFAULT 'none' NOT NULL,
	"credential_id" text,
	"mobile_device_id" uuid,
	"source" text DEFAULT 'self' NOT NULL,
	"reason" text,
	"work_mode" text,
	"evidence_path" text,
	"recorded_by_id" uuid
);

CREATE TABLE "attendance_month_freeze" (
	"month" text PRIMARY KEY NOT NULL,
	"frozen_at" timestamp with time zone DEFAULT now() NOT NULL,
	"frozen_by_id" uuid,
	"note" text
);

CREATE TABLE "attendance_sheet_day" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_name" text NOT NULL,
	"employee_id" uuid,
	"month" date NOT NULL,
	"day" smallint NOT NULL,
	"status_code" text NOT NULL,
	"date" date,
	"source" text DEFAULT 'attendance_log_sheet' NOT NULL,
	"imported_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "attendance_sheet_month" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy" text,
	"month" date NOT NULL,
	"employee_name" text NOT NULL,
	"employee_id" uuid,
	"designation" text,
	"company_name" text,
	"present" numeric(6, 2) DEFAULT '0' NOT NULL,
	"holiday" numeric(6, 2) DEFAULT '0' NOT NULL,
	"weekly_off" numeric(6, 2) DEFAULT '0' NOT NULL,
	"poh_full" numeric(6, 2) DEFAULT '0' NOT NULL,
	"poh_half" numeric(6, 2) DEFAULT '0' NOT NULL,
	"half_day" numeric(6, 2) DEFAULT '0' NOT NULL,
	"absent" numeric(6, 2) DEFAULT '0' NOT NULL,
	"days_in_month" numeric(6, 2) DEFAULT '0' NOT NULL,
	"total_days_worked" numeric(6, 2) DEFAULT '0' NOT NULL,
	"remark" text,
	"imported_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "audit_data_exports" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"requested_at" timestamp with time zone DEFAULT now() NOT NULL,
	"completed_at" timestamp with time zone,
	"file_path" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"error" text
);

CREATE TABLE "auth_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"firebase_uid" text NOT NULL,
	"session_hash" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"last_seen_at" timestamp with time zone DEFAULT now() NOT NULL,
	"user_agent" text,
	"ip_hash" text,
	"country" text,
	"city" text,
	"revoked_at" timestamp with time zone,
	CONSTRAINT "auth_sessions_session_hash_unique" UNIQUE("session_hash")
);

CREATE TABLE "broadcast_poll_responses" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"broadcast_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"option_index" integer NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "broadcast_recipients" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"broadcast_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"delivered_at" timestamp with time zone,
	"read_at" timestamp with time zone,
	"acknowledged_at" timestamp with time zone,
	"delivered_channels" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"last_reminded_at" timestamp with time zone,
	"reminder_count" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "broadcast_segments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"rule" jsonb NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "broadcast_templates" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"title" text DEFAULT '' NOT NULL,
	"body_html" text DEFAULT '' NOT NULL,
	"category" text DEFAULT 'announcement' NOT NULL,
	"priority" text DEFAULT 'normal' NOT NULL,
	"ack_mode" text DEFAULT 'read' NOT NULL,
	"channels" jsonb DEFAULT '["in_app","email"]'::jsonb NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "broadcasts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"body_html" text DEFAULT '' NOT NULL,
	"body_text" text DEFAULT '' NOT NULL,
	"category" text DEFAULT 'announcement' NOT NULL,
	"priority" text DEFAULT 'normal' NOT NULL,
	"ack_mode" text DEFAULT 'read' NOT NULL,
	"require_lock" boolean DEFAULT false NOT NULL,
	"status" text DEFAULT 'draft' NOT NULL,
	"author_id" uuid,
	"author_identity" text DEFAULT 'hr' NOT NULL,
	"sender_name" text,
	"attachments" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"audience" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"channels" jsonb DEFAULT '["in_app","email"]'::jsonb NOT NULL,
	"recipient_count" integer DEFAULT 0 NOT NULL,
	"scheduled_for" timestamp with time zone,
	"recurrence" text DEFAULT 'none' NOT NULL,
	"recurrence_until" date,
	"last_run_at" timestamp with time zone,
	"reminder_after_days" integer,
	"escalate_to_manager" boolean DEFAULT false NOT NULL,
	"poll" jsonb,
	"published_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "ca_handover_credentials" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"portal_type" text NOT NULL,
	"entity_name" text NOT NULL,
	"username" text,
	"password_enc" text,
	"phone" text,
	"default_email" text,
	"website_link" text,
	"email_updated" boolean DEFAULT false NOT NULL,
	"password_reset" boolean DEFAULT false NOT NULL,
	"primary_phone_updated" boolean DEFAULT false NOT NULL,
	"secondary_phone_updated" boolean DEFAULT false NOT NULL,
	"note" text,
	"sort_order" integer,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "ca_handover_returns" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"fy" text NOT NULL,
	"entity_name" text NOT NULL,
	"itr_v" text,
	"filed_computation" text,
	"filed_itr_form" text,
	"balance_sheet" text,
	"pnl" text,
	"tax_audit_report" text,
	"self_assessment_challan" text,
	"form_26as" text,
	"ais" text,
	"assessment_order" text,
	"refund_as_per_return" text,
	"refund_received" text,
	"gstr_1" text,
	"gstr_3b" text,
	"gstr_2b" text,
	"gst_working_excel" text,
	"gstr_9" text,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "calendar_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"category_id" uuid,
	"color_override" text,
	"event_date" date NOT NULL,
	"start_min" integer,
	"end_min" integer,
	"all_day" boolean DEFAULT false NOT NULL,
	"status" text DEFAULT 'confirmed' NOT NULL,
	"location" text,
	"notes" text,
	"source" text DEFAULT 'manual' NOT NULL,
	"source_ref_id" uuid,
	"is_locked" boolean DEFAULT false NOT NULL,
	"obligation_id" uuid,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "candidate_intake" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"position_applied" text,
	"full_name" text DEFAULT '' NOT NULL,
	"mobile" text,
	"email" text,
	"status" text DEFAULT 'new' NOT NULL,
	"data" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"instances" jsonb,
	"submitted_at" timestamp with time zone,
	"evaluation" jsonb,
	"evaluation_v2" jsonb,
	"photo_path" text,
	"signature_path" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "clients" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "clients_name_unique" UNIQUE("name")
);

CREATE TABLE "command_log" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"command_type" text NOT NULL,
	"dedupe_key" text NOT NULL,
	"payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"attempts" integer DEFAULT 0 NOT NULL,
	"correlation_id" uuid,
	"last_error" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"next_attempt_at" timestamp with time zone DEFAULT now() NOT NULL,
	"sent_at" timestamp with time zone
);

CREATE TABLE "comp_off_credits" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"earned_date" date NOT NULL,
	"redeemed_date" date,
	"status" text DEFAULT 'open' NOT NULL,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "ctc_breakups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"version" integer DEFAULT 1 NOT NULL,
	"reason" text DEFAULT 'initial' NOT NULL,
	"effective_date" date,
	"fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"growth_journey" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "daily_checklist" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"plan_date" date NOT NULL,
	"goal_id" uuid,
	"task_id" uuid,
	"cascade_goal_id" uuid,
	"origin" text DEFAULT 'standalone' NOT NULL,
	"title" text NOT NULL,
	"client" text,
	"subject" text,
	"position" integer DEFAULT 1 NOT NULL,
	"status" "task_status" DEFAULT 'not_started' NOT NULL,
	"done" boolean DEFAULT false NOT NULL,
	"done_pct" integer,
	"done_note" text,
	"committed_at" timestamp with time zone DEFAULT now() NOT NULL,
	"closed_at" timestamp with time zone,
	"moved_from_date" date,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "daily_checklist_reviews" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"plan_date" date NOT NULL,
	"reviewer_id" uuid,
	"status" text DEFAULT 'reviewed' NOT NULL,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "daily_plan_day" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"plan_date" date NOT NULL,
	"started_at" timestamp with time zone,
	"closed_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "dcc_clients" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_employee_id" uuid NOT NULL,
	"section" text NOT NULL,
	"name" text NOT NULL,
	"client_ref" uuid,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "dcc_entries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"entry_date" date NOT NULL,
	"status" text,
	"value_number" numeric(14, 2),
	"note" text,
	"filled_by_id" uuid,
	"subject_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "dcc_item_subjects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"item_id" uuid NOT NULL,
	"subject_id" uuid NOT NULL,
	"schedule_kind" text,
	"weekdays" smallint,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"archived" boolean DEFAULT false NOT NULL
);

CREATE TABLE "dcc_kpi_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_employee_id" uuid NOT NULL,
	"section" text,
	"code" text,
	"title" text NOT NULL,
	"frequency" text,
	"weekdays" smallint,
	"schedule_kind" text DEFAULT 'scheduled' NOT NULL,
	"is_participant_list" boolean DEFAULT false NOT NULL,
	"client_id" uuid,
	"template_code" text,
	"needs_review" boolean DEFAULT false NOT NULL,
	"target_number" numeric(14, 2),
	"unit" text,
	"sort_order" integer,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "dcc_reviews" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_employee_id" uuid NOT NULL,
	"review_date" date NOT NULL,
	"reviewer_id" uuid,
	"status" text,
	"note" text,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "dcc_subjects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_employee_id" uuid NOT NULL,
	"name" text NOT NULL,
	"kind" text,
	"external_ref" uuid,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "departments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "departments_name_unique" UNIQUE("name")
);

CREATE TABLE "designations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "designations_name_unique" UNIQUE("name")
);

CREATE TABLE "device_push_tokens" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"token" text NOT NULL,
	"platform" text DEFAULT 'android' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "document_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"document_id" uuid,
	"document_title" text NOT NULL,
	"actor_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"from_value" jsonb,
	"to_value" jsonb,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "document_instances" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"type_key" text NOT NULL,
	"employee_id" uuid,
	"candidate_name" text,
	"candidate_email" text,
	"status" text DEFAULT 'draft' NOT NULL,
	"merge_values" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"body_snapshot_md" text,
	"body_rich" jsonb,
	"body_html" text,
	"content_kind" text DEFAULT 'structured' NOT NULL,
	"rendered_pdf_path" text,
	"emailed_at" timestamp with time zone,
	"issued_by_id" uuid,
	"issued_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "document_signatures" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"doc_kind" text NOT NULL,
	"doc_id" uuid NOT NULL,
	"signer_employee_id" uuid,
	"status" text DEFAULT 'pending' NOT NULL,
	"method" text DEFAULT 'digilocker' NOT NULL,
	"verified_name" text,
	"verified_dob" text,
	"verified_gender" text,
	"verified_address" text,
	"masked_aadhaar" text,
	"photo_path" text,
	"digilocker_ref" text,
	"verified_at" timestamp with time zone,
	"signature_kind" text,
	"signature_text" text,
	"signature_image_path" text,
	"consent_text" text,
	"signed_pdf_path" text,
	"signed_at" timestamp with time zone,
	"ip" text,
	"user_agent" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "documents" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"storage_path" text NOT NULL,
	"mime_type" text,
	"size_bytes" integer,
	"task_id" uuid,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"uploaded_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "employee_departments" (
	"employee_id" uuid NOT NULL,
	"department_id" uuid NOT NULL,
	"is_primary" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "employee_departments_employee_id_department_id_pk" PRIMARY KEY("employee_id","department_id")
);

CREATE TABLE "employee_documents" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"doc_type" text NOT NULL,
	"title" text NOT NULL,
	"effective_date" date,
	"storage_path" text NOT NULL,
	"file_name" text NOT NULL,
	"mime_type" text,
	"size_bytes" bigint,
	"notes" text,
	"archived" boolean DEFAULT false NOT NULL,
	"uploaded_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "employee_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"actor_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"from_value" jsonb,
	"to_value" jsonb,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "employee_score_daily" (
	"day" date NOT NULL,
	"employee_id" uuid NOT NULL,
	"org_id" text,
	"presence_days" integer DEFAULT 0 NOT NULL,
	"late_count" integer DEFAULT 0 NOT NULL,
	"punctual_days" integer DEFAULT 0 NOT NULL,
	"goal_eff_sum_weighted" numeric(14, 2) DEFAULT '0' NOT NULL,
	"goal_weight_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"goals_completed" integer DEFAULT 0 NOT NULL,
	"goals_filled_on_time" integer DEFAULT 0 NOT NULL,
	"goal_progress_events" integer DEFAULT 0 NOT NULL,
	"dcc_due_count" integer DEFAULT 0 NOT NULL,
	"dcc_done_count" integer DEFAULT 0 NOT NULL,
	"tests_passed" integer DEFAULT 0 NOT NULL,
	"tests_attempted" integer DEFAULT 0 NOT NULL,
	"materials_watched" integer DEFAULT 0 NOT NULL,
	"feedback_count" integer DEFAULT 0 NOT NULL,
	"feedback_rating_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"feedback_resolved" integer DEFAULT 0 NOT NULL,
	"feedback_tat_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "employee_score_daily_day_employee_id_pk" PRIMARY KEY("day","employee_id")
);

CREATE TABLE "employee_twin" (
	"employee_id" uuid PRIMARY KEY NOT NULL,
	"org_id" text,
	"presence_days" integer DEFAULT 0 NOT NULL,
	"late_count" integer DEFAULT 0 NOT NULL,
	"punctual_days" integer DEFAULT 0 NOT NULL,
	"goal_eff_sum_weighted" numeric(14, 2) DEFAULT '0' NOT NULL,
	"goal_weight_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"goals_completed" integer DEFAULT 0 NOT NULL,
	"goals_filled_on_time" integer DEFAULT 0 NOT NULL,
	"goal_progress_events" integer DEFAULT 0 NOT NULL,
	"dcc_due_count" integer DEFAULT 0 NOT NULL,
	"dcc_done_count" integer DEFAULT 0 NOT NULL,
	"tests_passed" integer DEFAULT 0 NOT NULL,
	"tests_attempted" integer DEFAULT 0 NOT NULL,
	"materials_watched" integer DEFAULT 0 NOT NULL,
	"feedback_count" integer DEFAULT 0 NOT NULL,
	"feedback_rating_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"feedback_resolved" integer DEFAULT 0 NOT NULL,
	"feedback_tat_sum" numeric(14, 2) DEFAULT '0' NOT NULL,
	"last_event_at" timestamp with time zone,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "employees" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"role" "employee_role" NOT NULL,
	"avatar_url" text,
	"department" text,
	"department_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"firebase_uid" text,
	"is_admin" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"invited_at" timestamp with time zone,
	"joined_at" timestamp with time zone,
	"official_email" text,
	"personal_email" text,
	"email_provisioned_at" timestamp with time zone,
	"assets_allocated_at" timestamp with time zone,
	"password_reset_by_admin_at" timestamp with time zone,
	"attendance_biometric_exempt" boolean DEFAULT false NOT NULL,
	"last_inbox_visit_at" timestamp with time zone DEFAULT now() NOT NULL,
	"slack_user_id" text,
	"email_opt_in" boolean DEFAULT true NOT NULL,
	"slack_opt_in" boolean DEFAULT true NOT NULL,
	"whatsapp_phone" text,
	"whatsapp_opted_in" boolean DEFAULT false NOT NULL,
	"whatsapp_template_locale" text DEFAULT 'en' NOT NULL,
	"bio" text,
	"tags" text[] DEFAULT '{}'::text[] NOT NULL,
	"availability" text DEFAULT 'available' NOT NULL,
	"availability_auto_revert_at" timestamp with time zone,
	"timezone" text DEFAULT 'Asia/Kolkata' NOT NULL,
	"working_hours_start" time DEFAULT '10:00' NOT NULL,
	"working_hours_end" time DEFAULT '19:00' NOT NULL,
	"working_days" integer[] DEFAULT '{1,2,3,4,5,6}'::int[] NOT NULL,
	"quiet_hours_start" time,
	"quiet_hours_end" time,
	"digest_time" time DEFAULT '08:00' NOT NULL,
	"digest_frequency" text DEFAULT 'daily' NOT NULL,
	"theme" text DEFAULT 'system' NOT NULL,
	"density" text DEFAULT 'cozy' NOT NULL,
	"accent" text DEFAULT '#E10600' NOT NULL,
	"ooo_start" date,
	"ooo_end" date,
	"ooo_delegate_id" uuid,
	"manager_id" uuid,
	"daily_task_quota" integer DEFAULT 3 NOT NULL,
	"designation_id" uuid,
	"paying_entity_id" uuid,
	"mention_escalation" boolean DEFAULT true NOT NULL,
	"google_refresh_token" text,
	"google_email" text,
	"google_connected_at" timestamp with time zone,
	"weekly_off" integer DEFAULT 0 NOT NULL,
	"att_official_start" time,
	"att_late_after" time,
	"att_official_end" time,
	"att_early_before" time,
	"worker_type" text DEFAULT 'full_time' NOT NULL,
	"att_full_day_minutes" integer,
	"att_half_day_minutes" integer,
	"weekly_target_minutes" integer,
	"probation_end" date,
	"religion" text,
	CONSTRAINT "employees_email_unique" UNIQUE("email"),
	CONSTRAINT "employees_firebase_uid_unique" UNIQUE("firebase_uid")
);

CREATE TABLE "evaluation_weight_profiles" (
	"designation" text PRIMARY KEY NOT NULL,
	"weights" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "event_batch_schedules" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"batch_type_id" uuid NOT NULL,
	"name" text,
	"start_date" date NOT NULL,
	"end_date" date NOT NULL,
	"start_min" integer,
	"end_min" integer,
	"days_of_week" integer[],
	"category_id" uuid,
	"status" text DEFAULT 'confirmed' NOT NULL,
	"location" text,
	"notes" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "event_batch_types" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"default_category_id" uuid,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "event_batch_types_name_unique" UNIQUE("name")
);

CREATE TABLE "event_categories" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"color" text NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "event_categories_name_unique" UNIQUE("name")
);

CREATE TABLE "event_consumers" (
	"consumer" text PRIMARY KEY NOT NULL,
	"last_seq" bigint DEFAULT 0 NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "event_holidays" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"fy_start_year" integer NOT NULL,
	"holiday_date" date NOT NULL,
	"applies_to" text DEFAULT 'all' NOT NULL,
	"is_optional" boolean DEFAULT false NOT NULL,
	"is_office_closed" boolean DEFAULT true NOT NULL,
	"is_festival_marker" boolean DEFAULT false NOT NULL,
	"is_exam_marker" boolean DEFAULT false NOT NULL,
	"notes" text,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "event_log" (
	"seq" bigserial PRIMARY KEY NOT NULL,
	"event_id" uuid DEFAULT gen_random_uuid() NOT NULL,
	"aggregate_type" text NOT NULL,
	"aggregate_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"event_version" integer DEFAULT 1 NOT NULL,
	"payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"org_id" text,
	"correlation_id" uuid,
	"causation_id" uuid,
	"actor_id" uuid,
	"occurred_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "form_configs" (
	"form_key" text PRIMARY KEY NOT NULL,
	"fields" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_ai_insights" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"narrative" text DEFAULT '' NOT NULL,
	"suggestions" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"workload" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"source" text DEFAULT 'heuristic' NOT NULL,
	"model" text,
	"input_hash" text DEFAULT '' NOT NULL,
	"generated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_capture_log" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"batch_id" uuid,
	"channel" text NOT NULL,
	"raw_text" text,
	"transcript" text,
	"model" text,
	"row_count" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_comments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"parent_id" uuid,
	"author_id" uuid,
	"body" text NOT NULL,
	"edited_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_dependencies" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"on_goal_id" uuid,
	"on_weekly_goal_id" uuid,
	"kind" text DEFAULT 'depends_on' NOT NULL,
	"label" text DEFAULT '' NOT NULL,
	"resolved_at" timestamp with time zone,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_links" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"kind" text NOT NULL,
	"ref_table" text,
	"ref_id" uuid,
	"label" text DEFAULT '' NOT NULL,
	"meta" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_lookups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"kind" text NOT NULL,
	"value" text NOT NULL,
	"active" boolean DEFAULT true NOT NULL,
	"sort_order" integer,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goal_reviews" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid,
	"weekly_goal_id" uuid,
	"period" text,
	"self_pct" integer,
	"manager_pct" integer,
	"reviewer_id" uuid,
	"note" text,
	"evidence_url" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "goals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"period" text NOT NULL,
	"period_key" text NOT NULL,
	"parent_goal_id" uuid,
	"position" integer DEFAULT 1 NOT NULL,
	"area" text,
	"title" text NOT NULL,
	"uom" text,
	"target_qty" numeric(14, 2),
	"actual_qty" numeric(14, 2),
	"target_amount" numeric(14, 2),
	"actual_amount" numeric(14, 2),
	"notes" text,
	"team_involved" jsonb,
	"team_dependency_pct" integer,
	"share_with_team" boolean DEFAULT false NOT NULL,
	"delegated_to" jsonb,
	"pct_done" integer DEFAULT 0 NOT NULL,
	"accept_pct" integer,
	"review_notes" text,
	"evidence_url" text,
	"weight" integer DEFAULT 100 NOT NULL,
	"incentive_enabled" boolean DEFAULT false NOT NULL,
	"incentive_amount" numeric(14, 2),
	"incentive_kind" text,
	"monthly_master_ref" jsonb,
	"target_date" date,
	"status" "task_status" DEFAULT 'not_started' NOT NULL,
	"adopted" boolean DEFAULT true NOT NULL,
	"scope" text DEFAULT 'professional' NOT NULL,
	"source" text DEFAULT 'manual' NOT NULL,
	"capture_batch_id" uuid,
	"category" text DEFAULT 'goal' NOT NULL,
	"goal_type" text,
	"cloned_from_id" uuid,
	"reviewed_by_id" uuid,
	"reviewed_at" timestamp with time zone,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "holidays" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"holiday_date" date NOT NULL,
	"label" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "holidays_holiday_date_unique" UNIQUE("holiday_date")
);

CREATE TABLE "hr_confirmation_reminders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"kind" text NOT NULL,
	"notified_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "hr_ticket_attachments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ticket_id" uuid NOT NULL,
	"message_id" uuid,
	"uploaded_by_id" uuid,
	"storage_path" text NOT NULL,
	"file_name" text NOT NULL,
	"mime_type" text,
	"size_bytes" bigint,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "hr_ticket_messages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ticket_id" uuid NOT NULL,
	"author_id" uuid NOT NULL,
	"body" text NOT NULL,
	"internal" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "hr_ticket_routes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"category" text NOT NULL,
	"owner_id" uuid,
	"is_active" boolean DEFAULT true NOT NULL,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "hr_ticket_routes_category_unique" UNIQUE("category")
);

CREATE TABLE "hr_tickets" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ticket_no" integer DEFAULT nextval('hr_ticket_no_seq') NOT NULL,
	"employee_id" uuid NOT NULL,
	"category" text NOT NULL,
	"subject" text NOT NULL,
	"status" text DEFAULT 'new' NOT NULL,
	"priority" text DEFAULT 'normal' NOT NULL,
	"assignee_id" uuid,
	"confidential" boolean DEFAULT false NOT NULL,
	"source" text DEFAULT 'support' NOT NULL,
	"first_response_due_at" timestamp with time zone,
	"resolution_due_at" timestamp with time zone,
	"first_responded_at" timestamp with time zone,
	"sla_breached_at" timestamp with time zone,
	"resolved_at" timestamp with time zone,
	"closed_at" timestamp with time zone,
	"reopened_count" integer DEFAULT 0 NOT NULL,
	"csat_score" smallint,
	"csat_comment" text,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_catalog" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"sales_eligible" boolean,
	"interns_eligible" boolean,
	"notes" text,
	"sort_order" integer,
	"active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "incentive_catalog_name_unique" UNIQUE("name")
);

CREATE TABLE "incentive_config" (
	"id" text PRIMARY KEY DEFAULT 'default' NOT NULL,
	"pms_basis" text DEFAULT 'paid' NOT NULL,
	"excluded_names" jsonb DEFAULT '["Manan Vasa","Dattaram Kap","Parvez Khan"]'::jsonb NOT NULL,
	"attain_green_pct" numeric(6, 2) DEFAULT '100' NOT NULL,
	"attain_amber_pct" numeric(6, 2) DEFAULT '60' NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_entries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"src_sr_no" integer,
	"entry_date" date,
	"incentive_name" text NOT NULL,
	"period_month" date,
	"emp_name" text NOT NULL,
	"employee_id" uuid,
	"participant_name" text,
	"prospect_group_name" text,
	"amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"approved" boolean DEFAULT false NOT NULL,
	"approved_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid" boolean DEFAULT false NOT NULL,
	"paid_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_date" date,
	"booked_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"accrued_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"client_status" text,
	"payout_run_id" uuid,
	"paid_by_id" uuid,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_participants" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"entry_id" uuid,
	"project_id" uuid,
	"period_month" date,
	"emp_name" text NOT NULL,
	"employee_id" uuid,
	"booked_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"accrued_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_date" date,
	"payout_run_id" uuid,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_payout_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid,
	"emp_name" text,
	"source" text NOT NULL,
	"source_id" uuid,
	"salary_run_id" uuid,
	"period_month" date,
	"amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_date" date,
	"created_by_id" uuid,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_projects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"src_sr_no" integer,
	"subject" text,
	"project_name" text,
	"initiator_name" text,
	"supervisor_name" text,
	"supervisor_id" uuid,
	"intern_name" text,
	"intern_id" uuid,
	"project_details" text,
	"period_month" date,
	"approved" boolean DEFAULT false NOT NULL,
	"emp_amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"intern_amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"emp_approved_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"intern_approved_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid" boolean DEFAULT false NOT NULL,
	"emp_paid_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"intern_paid_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_date" date,
	"emp_booked_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"emp_accrued_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"intern_booked_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"intern_accrued_amt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"payout_run_id" uuid,
	"initiator_notes" text,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_requests" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"type" text NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"details" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"decided_by_id" uuid,
	"decided_at" timestamp with time zone,
	"decision_note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "incentive_targets" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"emp_name" text NOT NULL,
	"employee_id" uuid,
	"period_month" date NOT NULL,
	"target_amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "index_links" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"section_id" uuid NOT NULL,
	"label" text NOT NULL,
	"url" text NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "index_sections" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "interview_positions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"label" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "interview_positions_label_unique" UNIQUE("label")
);

CREATE TABLE "kpi_assignment_history" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"assignment_id" uuid NOT NULL,
	"change_type" text NOT NULL,
	"previous" jsonb,
	"updated" jsonb,
	"changed_by_id" uuid,
	"changed_on" timestamp with time zone DEFAULT now() NOT NULL,
	"reason" text
);

CREATE TABLE "kpi_assignments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"kpi_key" text,
	"kpi_name" text NOT NULL,
	"category" text DEFAULT '' NOT NULL,
	"frequency" text DEFAULT 'monthly' NOT NULL,
	"weightage" integer DEFAULT 0 NOT NULL,
	"effective_quarter" text DEFAULT '' NOT NULL,
	"target_value" text DEFAULT '' NOT NULL,
	"current_value" text,
	"applicable" boolean DEFAULT true NOT NULL,
	"status" text DEFAULT 'active' NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"archived" boolean DEFAULT false NOT NULL
);

CREATE TABLE "leave_requests" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"kind" text NOT NULL,
	"start_date" date NOT NULL,
	"end_date" date NOT NULL,
	"days" numeric(5, 1) NOT NULL,
	"reason" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"decided_by_id" uuid,
	"decided_at" timestamp with time zone,
	"decision_note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "letter_templates" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"category" text NOT NULL,
	"type_key" text NOT NULL,
	"title" text NOT NULL,
	"body_md" text DEFAULT '' NOT NULL,
	"trigger" text DEFAULT 'issued' NOT NULL,
	"signature" text DEFAULT 'none' NOT NULL,
	"content" text DEFAULT 'text' NOT NULL,
	"active" boolean DEFAULT true NOT NULL,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "mobile_devices" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"device_id" text NOT NULL,
	"label" text,
	"platform" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"last_used_at" timestamp with time zone
);

CREATE TABLE "module_submissions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"module" text NOT NULL,
	"employee_id" uuid NOT NULL,
	"fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"admin_fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"decided_by_id" uuid,
	"decided_at" timestamp with time zone,
	"archived" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "notification_dispatch_log" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"notification_id" uuid NOT NULL,
	"channel" text NOT NULL,
	"status" text NOT NULL,
	"error_message" text,
	"attempt_count" integer DEFAULT 1 NOT NULL,
	"attempted_at" timestamp with time zone DEFAULT now() NOT NULL,
	"next_attempt_at" timestamp with time zone,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "notification_preferences" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"kind" text NOT NULL,
	"channel" text NOT NULL,
	"enabled" boolean DEFAULT true NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "notifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"task_id" uuid,
	"event_id" uuid,
	"kind" text NOT NULL,
	"title" text NOT NULL,
	"body" text,
	"actor_id" uuid,
	"read_at" timestamp with time zone,
	"email_sent_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"delivered_channels" text[] DEFAULT '{}' NOT NULL
);

CREATE TABLE "obligation_completions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"obligation_id" uuid NOT NULL,
	"fy_start_year" integer NOT NULL,
	"period_month" integer NOT NULL,
	"completed_count" integer DEFAULT 0 NOT NULL,
	"note" text,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "obligations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"counterparty" text,
	"cadence" text DEFAULT 'monthly' NOT NULL,
	"target_count" integer DEFAULT 1 NOT NULL,
	"is_compulsory" boolean DEFAULT true NOT NULL,
	"penalty_note" text,
	"category_id" uuid,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "onboarding_submissions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"files" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"status" text DEFAULT 'submitted' NOT NULL,
	"submitted_at" timestamp with time zone,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "org_settings" (
	"id" integer PRIMARY KEY DEFAULT 1 NOT NULL,
	"company_name" text DEFAULT 'Altus Corp' NOT NULL,
	"logo_url" text,
	"admin_pin_hash" text,
	"digest_hour_ist" integer DEFAULT 9 NOT NULL,
	"idle_timeout_minutes" integer DEFAULT 10 NOT NULL,
	"working_days" integer[] DEFAULT array[1,2,3,4,5] NOT NULL,
	"timezone" text DEFAULT 'Asia/Kolkata' NOT NULL,
	"allow_self_register" boolean DEFAULT false NOT NULL,
	"notification_matrix" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"board_column_order" jsonb,
	"office_lat" double precision,
	"office_lng" double precision,
	"attendance_radius_m" integer DEFAULT 100 NOT NULL,
	"office_ip_allowlist" text[],
	"att_late_after" time DEFAULT '10:50',
	"att_early_before" time DEFAULT '19:30',
	"att_full_day_hours" numeric DEFAULT '9',
	"att_half_day_hours" numeric DEFAULT '5',
	"hr_assignment_owner_id" uuid,
	"evaluation_weights" jsonb,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_by_id" uuid
);

CREATE TABLE "outstanding_attachments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_type" text NOT NULL,
	"owner_id" uuid NOT NULL,
	"storage_path" text NOT NULL,
	"file_name" text NOT NULL,
	"mime_type" text,
	"size_bytes" integer,
	"uploaded_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_collections" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"client_name" text NOT NULL,
	"contract_id" uuid,
	"amount" numeric(14, 2) NOT NULL,
	"payment_mode_id" uuid,
	"responsible_id" uuid,
	"collected_at" date NOT NULL,
	"comments" text,
	"import_batch_id" uuid,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_contracts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"client_name" text NOT NULL,
	"contact_phone" text,
	"product_id" uuid,
	"entity_id" uuid,
	"responsible_id" uuid,
	"expected_mode_id" uuid,
	"cycle" text NOT NULL,
	"first_name" text,
	"last_name" text,
	"base_amount" numeric(14, 2) NOT NULL,
	"gst_rate" integer DEFAULT 0 NOT NULL,
	"start_date" date NOT NULL,
	"retainer_start" date,
	"retainer_end" date,
	"bill_date" integer,
	"emi_count" integer,
	"frequency" text,
	"periods" integer,
	"end_date" date,
	"pdc_received" boolean DEFAULT false NOT NULL,
	"comments" text,
	"import_batch_id" uuid,
	"status" text DEFAULT 'active' NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_entities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "outstanding_entities_name_unique" UNIQUE("name")
);

CREATE TABLE "outstanding_entries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"client" text NOT NULL,
	"particulars" text,
	"amount" numeric(14, 2) NOT NULL,
	"amount_received" numeric(14, 2) DEFAULT '0' NOT NULL,
	"due_date" date,
	"status" text DEFAULT 'open' NOT NULL,
	"owner_id" uuid,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_followups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"entry_id" uuid NOT NULL,
	"actor_id" uuid NOT NULL,
	"note" text NOT NULL,
	"promised_date" date,
	"amount_received" numeric(14, 2),
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_installments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"contract_id" uuid,
	"period_index" integer,
	"due_date" date NOT NULL,
	"amount" numeric(14, 2) NOT NULL,
	"is_override" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "outstanding_payment_modes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "outstanding_payment_modes_name_unique" UNIQUE("name")
);

CREATE TABLE "outstanding_products" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "outstanding_products_name_unique" UNIQUE("name")
);

CREATE TABLE "outstanding_responsibles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "outstanding_responsibles_name_unique" UNIQUE("name")
);

CREATE TABLE "overtime_entries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"work_date" date NOT NULL,
	"hours" numeric(5, 2) NOT NULL,
	"reason" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"approved_by_id" uuid,
	"approved_at" timestamp with time zone,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "paid_leave_cycle" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_name" text NOT NULL,
	"employee_id" uuid,
	"doj" date,
	"period" text NOT NULL,
	"status" text,
	"leaves" numeric(6, 2),
	"remarks" text,
	"imported_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "paying_entities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "paying_entities_name_unique" UNIQUE("name")
);

CREATE TABLE "performance_scorecards" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid,
	"person_key" text NOT NULL,
	"person_name" text DEFAULT '' NOT NULL,
	"period_month" text NOT NULL,
	"role_class" text DEFAULT 'non-manager' NOT NULL,
	"kpi_actuals" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"bucket_scores" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"computed" jsonb,
	"total_score" numeric(6, 2),
	"incentive_pct" numeric(6, 2),
	"narrative" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pg_business_categories" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pg_designations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pg_introductions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"received_on" date DEFAULT CURRENT_DATE NOT NULL,
	"reference_source_id" uuid,
	"introducer_first_name" text NOT NULL,
	"introducer_last_name" text NOT NULL,
	"introducer_cell" text,
	"prospect_company" text NOT NULL,
	"prospect_first_name" text NOT NULL,
	"prospect_last_name" text NOT NULL,
	"designation_id" uuid,
	"business_category_id" uuid,
	"nature_of_business" text NOT NULL,
	"notes" text,
	"next_reminder_date" date,
	"sales_person_id" uuid,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pg_reference_sources" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pg_sales_people" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pinned_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"kind" text NOT NULL,
	"item_id" uuid NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"pinned_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_monthly_review" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"subject_id" uuid NOT NULL,
	"reviewer_id" uuid,
	"relation" text DEFAULT 'manager' NOT NULL,
	"period" text NOT NULL,
	"attitude" smallint,
	"behaviour" smallint,
	"skill" smallint,
	"change_tags" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"explanation" text,
	"scope" text DEFAULT 'internal' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_personal_goal" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"period" text NOT NULL,
	"title" text NOT NULL,
	"detail" text,
	"status" text DEFAULT 'active' NOT NULL,
	"position" smallint DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_promotion_signal" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"score_snapshot" numeric(6, 2),
	"eligible_since" timestamp with time zone,
	"rationale" text,
	"status" text DEFAULT 'flagged' NOT NULL,
	"decided_by_id" uuid,
	"decided_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_recognition" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"period" text NOT NULL,
	"kind" text NOT NULL,
	"reason" text,
	"score_snapshot" numeric(6, 2),
	"status" text DEFAULT 'suggested' NOT NULL,
	"released_by_id" uuid,
	"released_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_review" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"period" text NOT NULL,
	"reviewer_id" uuid,
	"rating" smallint,
	"status" text DEFAULT 'draft' NOT NULL,
	"strengths" text,
	"improvements" text,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "pms_score_config" (
	"id" text PRIMARY KEY DEFAULT 'default' NOT NULL,
	"weights" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"thresholds" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"formula" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "policy_compliance" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"policy_key" text NOT NULL,
	"version" integer NOT NULL,
	"employee_id" uuid NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"signed_at" timestamp with time zone,
	"doc_instance_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "policy_documents" (
	"key" text PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"doc_code" text DEFAULT '' NOT NULL,
	"category" text DEFAULT 'policy' NOT NULL,
	"badge" text DEFAULT '' NOT NULL,
	"blurb" text DEFAULT '' NOT NULL,
	"summary" text DEFAULT '' NOT NULL,
	"owner" text DEFAULT '' NOT NULL,
	"registered_office" text DEFAULT '' NOT NULL,
	"hr_email" text DEFAULT '' NOT NULL,
	"entity_default" text DEFAULT 'altus-corp' NOT NULL,
	"current_version" integer DEFAULT 1 NOT NULL,
	"status" text DEFAULT 'published' NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "policy_versions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"policy_key" text NOT NULL,
	"version" integer NOT NULL,
	"title" text NOT NULL,
	"doc_code" text DEFAULT '' NOT NULL,
	"effective_date" text DEFAULT '' NOT NULL,
	"summary" text DEFAULT '' NOT NULL,
	"sections" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"published_by_id" uuid,
	"published_at" timestamp with time zone DEFAULT now() NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "product_options" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"label" text NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "project_members" (
	"project_node_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "project_members_project_node_id_employee_id_pk" PRIMARY KEY("project_node_id","employee_id")
);

CREATE TABLE "project_nodes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"kind" text NOT NULL,
	"parent_id" uuid,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"is_archived" boolean DEFAULT false NOT NULL,
	"description" text,
	"notes" text,
	"target_date" timestamp with time zone,
	"owner_id" uuid,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "push_subscriptions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"endpoint" text NOT NULL,
	"p256dh" text NOT NULL,
	"auth" text NOT NULL,
	"user_agent" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"last_seen_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "push_subscriptions_endpoint_unique" UNIQUE("endpoint")
);

CREATE TABLE "rev_agent_audit" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"run_id" uuid NOT NULL,
	"user_id" uuid,
	"tool" text NOT NULL,
	"args_json" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"result_summary" text,
	"status" text DEFAULT 'ok' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "rev_agent_runs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"agent_slug" text NOT NULL,
	"user_id" uuid,
	"surface" text,
	"status" text DEFAULT 'running' NOT NULL,
	"input_json" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"output_summary" text,
	"token_usage" integer DEFAULT 0 NOT NULL,
	"started_at" timestamp with time zone DEFAULT now() NOT NULL,
	"finished_at" timestamp with time zone
);

CREATE TABLE "rev_campaigns" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"type" text DEFAULT 'outreach' NOT NULL,
	"host_id" uuid,
	"scheduled_at" timestamp with time zone,
	"status" text DEFAULT 'planned' NOT NULL,
	"notes" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "rev_drafts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"kind" text NOT NULL,
	"lead_id" uuid,
	"agent_slug" text,
	"created_by_run" uuid,
	"channel" text,
	"subject" text,
	"body" text,
	"status" text DEFAULT 'pending' NOT NULL,
	"suppression_status" text DEFAULT 'clear' NOT NULL,
	"approved_by" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "rev_lead_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"lead_id" uuid NOT NULL,
	"type" text NOT NULL,
	"payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "rev_leads" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"company" text,
	"contact_email" text,
	"contact_phone" text,
	"source" text,
	"status" text DEFAULT 'new' NOT NULL,
	"owner_id" uuid,
	"score" numeric(6, 2),
	"score_reasons" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"enriched_json" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"referral_id" uuid,
	"in_review" boolean DEFAULT true NOT NULL,
	"created_by" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "rev_suppression" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"contact_email" text,
	"contact_phone" text,
	"reason" text DEFAULT 'opt_out' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_advances" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"advance_date" date NOT NULL,
	"fy" text NOT NULL,
	"month" text NOT NULL,
	"amount" numeric(14, 2) NOT NULL,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_breakup" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sr_no" integer,
	"fy" text,
	"month" date NOT NULL,
	"employee_name" text NOT NULL,
	"employee_id" uuid,
	"designation" text,
	"company_name" text,
	"present" numeric(6, 2) DEFAULT '0',
	"holiday" numeric(6, 2) DEFAULT '0',
	"weekly_off" numeric(6, 2) DEFAULT '0',
	"poh_full" numeric(6, 2) DEFAULT '0',
	"poh_half" numeric(6, 2) DEFAULT '0',
	"half_day" numeric(6, 2) DEFAULT '0',
	"absent" numeric(6, 2) DEFAULT '0',
	"days_in_month" numeric(6, 2) DEFAULT '0',
	"total_days_worked" numeric(6, 2) DEFAULT '0',
	"set_off" numeric(6, 2),
	"cf" numeric(6, 2),
	"final_working_days" numeric(6, 2) DEFAULT '0',
	"pay_type" text DEFAULT 'monthly_ctc' NOT NULL,
	"worked_hours" numeric(8, 2),
	"annual_ctc" numeric(14, 2) DEFAULT '0',
	"monthly_ctc" numeric(14, 2) DEFAULT '0',
	"payable_after_leave" numeric(14, 2) DEFAULT '0',
	"pt" numeric(14, 2) DEFAULT '0',
	"payable_after_pt" numeric(14, 2) DEFAULT '0',
	"advance" numeric(14, 2) DEFAULT '0',
	"previous_pending" numeric(14, 2) DEFAULT '0',
	"final_payment" numeric(14, 2) DEFAULT '0',
	"salary_given" numeric(14, 2),
	"remarks" text,
	"manan_remarks" text,
	"paid" boolean DEFAULT false NOT NULL,
	"paid_at" timestamp with time zone,
	"paid_by_id" uuid,
	"admin_note" text,
	"admin_note_at" timestamp with time zone,
	"admin_note_by_id" uuid,
	"waive_off_days" numeric(6, 2) DEFAULT '0' NOT NULL,
	"waive_off_note" text,
	"waive_off_at" timestamp with time zone,
	"waive_off_by_id" uuid,
	"payout_adjustment" numeric(14, 2) DEFAULT '0' NOT NULL,
	"payout_adjustment_note" text,
	"payout_adjustment_at" timestamp with time zone,
	"payout_adjustment_by_id" uuid,
	"imported_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_config" (
	"id" text PRIMARY KEY DEFAULT 'default' NOT NULL,
	"divisor_policy" text DEFAULT 'actual' NOT NULL,
	"fixed_divisor" integer DEFAULT 31 NOT NULL,
	"free_training_days" integer DEFAULT 7 NOT NULL,
	"default_pt" numeric(14, 2) DEFAULT '200' NOT NULL,
	"salary_day_of_month" integer DEFAULT 10 NOT NULL,
	"joiner_leave_accrual" jsonb DEFAULT '[3,4,3,4,3,4]'::jsonb NOT NULL,
	"updated_by_id" uuid,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_payments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid,
	"salary_run_id" uuid,
	"month" text,
	"kind" text DEFAULT 'salary' NOT NULL,
	"incentive_entry_id" uuid,
	"amount" numeric(14, 2) DEFAULT '0' NOT NULL,
	"paid_date" date,
	"method" text,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_policies" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"version" text NOT NULL,
	"storage_path" text NOT NULL,
	"uploaded_by_id" uuid,
	"is_current" boolean DEFAULT true NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_policy_consents" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"policy_version" text NOT NULL,
	"signed_at" timestamp with time zone DEFAULT now() NOT NULL,
	"signature_kind" text NOT NULL,
	"signature_path" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "salary_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"annual_ctc" numeric(14, 2) DEFAULT '0' NOT NULL,
	"tds_monthly" numeric(14, 2) DEFAULT '0' NOT NULL,
	"pt_exempt" boolean DEFAULT false NOT NULL,
	"pay_type" text DEFAULT 'monthly_ctc' NOT NULL,
	"monthly_pay_at_target" numeric(14, 2),
	"weekly_target_hours" numeric(6, 2),
	"monthly_fee" numeric(14, 2),
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "salary_profiles_employee_id_unique" UNIQUE("employee_id")
);

CREATE TABLE "salary_runs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"fy" text NOT NULL,
	"month" text NOT NULL,
	"annual_ctc" numeric(14, 2) NOT NULL,
	"days_in_month" integer NOT NULL,
	"payable_days" numeric(6, 2) NOT NULL,
	"late_marks" integer DEFAULT 0 NOT NULL,
	"late_deduction_days" numeric(6, 2) DEFAULT '0' NOT NULL,
	"gross" numeric(14, 2) NOT NULL,
	"pt" numeric(14, 2) DEFAULT '0' NOT NULL,
	"tds" numeric(14, 2) DEFAULT '0' NOT NULL,
	"advances" numeric(14, 2) DEFAULT '0' NOT NULL,
	"pending_balance_in" numeric(14, 2) DEFAULT '0' NOT NULL,
	"net_payable" numeric(14, 2) NOT NULL,
	"pay_type" text DEFAULT 'monthly_ctc' NOT NULL,
	"worked_hours" numeric(8, 2),
	"hourly_rate" numeric(10, 2),
	"disbursed" boolean DEFAULT false NOT NULL,
	"disbursed_amount" numeric(14, 2),
	"approved_by_id" uuid,
	"generated_by_id" uuid,
	"source" text DEFAULT 'generated' NOT NULL,
	"import_batch_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "settings_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"scope" text NOT NULL,
	"target_id" text,
	"actor_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"from_value" jsonb,
	"to_value" jsonb,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "skill_lookups" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"kind" text NOT NULL,
	"value" text NOT NULL,
	"active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "status_settings" (
	"status" "task_status" PRIMARY KEY NOT NULL,
	"label" text NOT NULL,
	"color_token" text NOT NULL,
	"display_order" integer NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_by_id" uuid
);

CREATE TABLE "subjects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "subjects_name_unique" UNIQUE("name")
);

CREATE TABLE "sync_runs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"job" text NOT NULL,
	"trigger" text NOT NULL,
	"actor_id" uuid,
	"dry_run" boolean DEFAULT false NOT NULL,
	"started_at" timestamp with time zone DEFAULT now() NOT NULL,
	"finished_at" timestamp with time zone,
	"status" text DEFAULT 'running' NOT NULL,
	"rows_read" integer DEFAULT 0 NOT NULL,
	"rows_written" integer DEFAULT 0 NOT NULL,
	"rows_skipped" integer DEFAULT 0 NOT NULL,
	"unmatched_names" text[] DEFAULT '{}'::text[] NOT NULL,
	"error" text
);

CREATE TABLE "task_attachments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"task_id" uuid NOT NULL,
	"storage_path" text NOT NULL,
	"file_name" text NOT NULL,
	"mime" text,
	"size_bytes" integer,
	"uploaded_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_checklist_items" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"task_id" uuid NOT NULL,
	"label" text NOT NULL,
	"done" boolean DEFAULT false NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_by_id" uuid,
	"done_by_id" uuid,
	"done_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"task_id" uuid NOT NULL,
	"actor_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"from_value" jsonb,
	"to_value" jsonb,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_metrics_daily" (
	"day" date NOT NULL,
	"doer_id" uuid NOT NULL,
	"org_id" text,
	"created_count" integer DEFAULT 0 NOT NULL,
	"done_count" integer DEFAULT 0 NOT NULL,
	"approved_count" integer DEFAULT 0 NOT NULL,
	"not_approved_count" integer DEFAULT 0 NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "task_metrics_daily_day_doer_id_pk" PRIMARY KEY("day","doer_id")
);

CREATE TABLE "task_time_consent" (
	"employee_id" uuid PRIMARY KEY NOT NULL,
	"consented_at" timestamp with time zone DEFAULT now() NOT NULL,
	"policy_version" text NOT NULL
);

CREATE TABLE "task_time_events" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"task_id" uuid NOT NULL,
	"actor_id" uuid NOT NULL,
	"doer_id" uuid NOT NULL,
	"kind" text NOT NULL,
	"revision" integer DEFAULT 1 NOT NULL,
	"at" timestamp with time zone DEFAULT now() NOT NULL,
	"session_id" uuid,
	"meta" jsonb,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_time_rollup" (
	"task_id" uuid PRIMARY KEY NOT NULL,
	"total_active_seconds" integer DEFAULT 0 NOT NULL,
	"original_seconds" integer DEFAULT 0 NOT NULL,
	"revision_seconds" integer DEFAULT 0 NOT NULL,
	"session_count" integer DEFAULT 0 NOT NULL,
	"pause_count" integer DEFAULT 0 NOT NULL,
	"rejection_count" integer DEFAULT 0 NOT NULL,
	"current_revision" integer DEFAULT 1 NOT NULL,
	"longest_session_sec" integer DEFAULT 0 NOT NULL,
	"shortest_session_sec" integer,
	"first_started_at" timestamp with time zone,
	"last_done_at" timestamp with time zone,
	"approved_at" timestamp with time zone,
	"open_session_count" integer DEFAULT 0 NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_work_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"task_id" uuid NOT NULL,
	"doer_id" uuid NOT NULL,
	"revision" integer DEFAULT 1 NOT NULL,
	"started_at" timestamp with time zone NOT NULL,
	"ended_at" timestamp with time zone,
	"duration_seconds" integer,
	"end_reason" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "task_work_snapshots" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"task_id" uuid NOT NULL,
	"doer_id" uuid NOT NULL,
	"storage_path" text NOT NULL,
	"captured_at" timestamp with time zone NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tasks" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"doer_id" uuid NOT NULL,
	"initiator_id" uuid NOT NULL,
	"priority" "task_priority" DEFAULT 'not_imp_not_urgent' NOT NULL,
	"status" "task_status" DEFAULT 'not_started' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"due_at" timestamp with time zone NOT NULL,
	"completed_at" timestamp with time zone,
	"transferred_from_id" uuid,
	"notes" text,
	"subject" text,
	"client" text,
	"google_event_id" text,
	"google_synced_doer_id" uuid,
	"calendar_attempts" integer DEFAULT 0 NOT NULL,
	"calendar_next_attempt_at" timestamp with time zone,
	"calendar_last_sync_at" timestamp with time zone,
	"calendar_last_error" text,
	"archived" boolean DEFAULT false NOT NULL,
	"abandoned_at" timestamp with time zone,
	"abandoned_by_id" uuid,
	"created_by_id" uuid,
	"approved_by_id" uuid,
	"approved_at" timestamp with time zone,
	"approval_note" text,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	"legacy_import_key" text,
	"short_id" text,
	"task_no" integer,
	"tags" text[],
	"approval_status" "approval_status",
	"revised_target_date" timestamp with time zone,
	"first_read_at" timestamp with time zone,
	"starts_at" timestamp with time zone,
	"ends_at" timestamp with time zone,
	"all_day" boolean DEFAULT false NOT NULL,
	"recurrence" text,
	"recurrence_rule" text,
	"recurrence_parent_id" uuid,
	"recurrence_occurrence_date" text,
	"project_node_id" uuid,
	"search_text" text GENERATED ALWAYS AS (coalesce(title,'') || ' ' || coalesce(description,'') || ' ' || coalesce(client,'') || ' ' || coalesce(subject,'') || ' ' || coalesce(notes,'')) STORED,
	"origin_goal_id" uuid,
	"amb_referral_id" uuid,
	"estimated_minutes" integer
);

CREATE TABLE "tc_assessments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid,
	"employee_id" uuid NOT NULL,
	"score" smallint,
	"target" smallint,
	"passed" boolean,
	"waived" boolean DEFAULT false NOT NULL,
	"waived_by_id" uuid,
	"redo_of_id" uuid,
	"assessed_by_id" uuid,
	"note" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_attempts" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"test_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"score" integer NOT NULL,
	"passed" boolean NOT NULL,
	"answers" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"taken_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_feedback" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"feedback_date" date DEFAULT CURRENT_DATE NOT NULL,
	"rated_employee_id" uuid,
	"rated_name" text,
	"client_name" text,
	"service_id" uuid,
	"type" text NOT NULL,
	"rating" integer,
	"q1" text,
	"q2" text,
	"voice_note_path" text,
	"voice_transcript" text,
	"picture_path" text,
	"escalate" boolean DEFAULT false NOT NULL,
	"escalated_to_id" uuid,
	"resolution" boolean DEFAULT false NOT NULL,
	"resolution_how" text,
	"signed_off" boolean DEFAULT false NOT NULL,
	"signed_off_by_id" uuid,
	"signed_off_at" timestamp with time zone,
	"archived" boolean DEFAULT false NOT NULL,
	"status" text DEFAULT 'open' NOT NULL,
	"resolved_at" timestamp with time zone,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_materials" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"added_on" date DEFAULT CURRENT_DATE NOT NULL,
	"subject_id" uuid,
	"los" text,
	"file_path" text,
	"file_name" text,
	"file_type" text,
	"video_url" text,
	"notes" text,
	"version" text,
	"version_notes" text,
	"created_by_ids" uuid[] DEFAULT '{}'::uuid[] NOT NULL,
	"assisted_by_ids" uuid[] DEFAULT '{}'::uuid[] NOT NULL,
	"part_of_induction" boolean DEFAULT false NOT NULL,
	"induction_dept_ids" uuid[] DEFAULT '{}'::uuid[] NOT NULL,
	"archived" boolean DEFAULT false NOT NULL,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_questions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"test_id" uuid NOT NULL,
	"type" text NOT NULL,
	"prompt" text NOT NULL,
	"options" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"correct_answers" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"marks" integer DEFAULT 1 NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_self_learning" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"learn_date" date NOT NULL,
	"kind" text DEFAULT 'book' NOT NULL,
	"title" text NOT NULL,
	"source_url" text,
	"minutes" integer DEFAULT 0 NOT NULL,
	"evidence_path" text,
	"evidence_url" text,
	"notes" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_services" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_session_attendees" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"status" text DEFAULT 'invited' NOT NULL,
	"attended_min" integer,
	"marked_by_id" uuid,
	"marked_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_session_feedback" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"content" smallint,
	"depth" smallint,
	"understanding" smallint,
	"applicability" smallint,
	"learned" text,
	"improve" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"subject_id" uuid,
	"topic" text NOT NULL,
	"los" text,
	"criticality" smallint DEFAULT 3 NOT NULL,
	"trainer_id" uuid,
	"scheduled_at" timestamp with time zone NOT NULL,
	"duration_min" integer DEFAULT 60 NOT NULL,
	"mode" text DEFAULT 'in_person' NOT NULL,
	"location" text,
	"meeting_url" text,
	"video_path" text,
	"ppt_path" text,
	"status" text DEFAULT 'scheduled' NOT NULL,
	"in_manual" boolean DEFAULT false NOT NULL,
	"material_id" uuid,
	"recording_requested" boolean DEFAULT false NOT NULL,
	"notes" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_share_feedback" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"share_id" uuid NOT NULL,
	"rater_id" uuid NOT NULL,
	"rating" smallint,
	"comment" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_shares" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"week_start" date NOT NULL,
	"topic" text NOT NULL,
	"minutes" integer DEFAULT 10 NOT NULL,
	"video_path" text,
	"video_url" text,
	"notes" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_subjects" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 100 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_tests" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"material_id" uuid NOT NULL,
	"kind" integer NOT NULL,
	"title" text,
	"pass_mark" integer NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "tc_watch_progress" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"material_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"watched_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "webauthn_credentials" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"credential_id" text NOT NULL,
	"public_key" text NOT NULL,
	"counter" bigint DEFAULT 0 NOT NULL,
	"transports" text,
	"device_label" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"last_used_at" timestamp with time zone,
	CONSTRAINT "webauthn_credentials_credential_id_unique" UNIQUE("credential_id")
);

CREATE TABLE "weekly_goal_actuals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"goal_id" uuid NOT NULL,
	"employee_id" uuid NOT NULL,
	"entry_date" date NOT NULL,
	"pct" integer,
	"note" text,
	"created_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "weekly_goals" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"week_start" date NOT NULL,
	"position" integer DEFAULT 1 NOT NULL,
	"client" text,
	"subject" text,
	"priority" "task_priority" DEFAULT 'imp_not_urgent' NOT NULL,
	"incentive" boolean DEFAULT false NOT NULL,
	"incentive_amount" integer DEFAULT 0 NOT NULL,
	"incentive_type" text,
	"incentive_catalog_id" uuid,
	"kpi" boolean DEFAULT false NOT NULL,
	"goal_type" text,
	"target_done" text,
	"pct_done" integer DEFAULT 0 NOT NULL,
	"pct_updated_by_id" uuid,
	"pct_updated_at" timestamp with time zone,
	"explanation" text,
	"link_url" text,
	"weight" integer DEFAULT 100 NOT NULL,
	"target_date" date,
	"notes" text,
	"status" "task_status" DEFAULT 'not_started' NOT NULL,
	"accept_pct" integer,
	"review_notes" text,
	"archived" boolean DEFAULT false NOT NULL,
	"reviewed_by_id" uuid,
	"reviewed_at" timestamp with time zone,
	"approved_at" timestamp with time zone,
	"carried_from_id" uuid,
	"task_id" uuid,
	"month_goal_id" uuid,
	"area" text,
	"uom" text,
	"target_qty" numeric(14, 2),
	"target_amount" numeric(14, 2),
	"actual_qty" numeric(14, 2),
	"actual_amount" numeric(14, 2),
	"team_involved" jsonb,
	"team_dependency_pct" integer,
	"delegated_to" jsonb,
	"share_with_team" boolean DEFAULT false NOT NULL,
	"evidence_url" text,
	"adopted" boolean DEFAULT true NOT NULL,
	"committed_at" timestamp with time zone,
	"approved_by_manager_at" timestamp with time zone,
	"created_by_id" uuid,
	"updated_by_id" uuid,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "whatsapp_media_log" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"recipient_phone" text NOT NULL,
	"media_kind" text NOT NULL,
	"template_name" text,
	"context" text NOT NULL,
	"ref_key" text NOT NULL,
	"meta_message_id" text,
	"status" text,
	"error" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "work_session_shots" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" uuid NOT NULL,
	"path" text NOT NULL,
	"taken_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE "work_sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"employee_id" uuid NOT NULL,
	"started_at" timestamp with time zone NOT NULL,
	"ended_at" timestamp with time zone,
	"source" text NOT NULL,
	"meet_space_id" text,
	"meet_conference_record" text,
	"meet_participant" text,
	"total_minutes" numeric(8, 2),
	"screenshot_count" integer DEFAULT 0 NOT NULL,
	"status" text DEFAULT 'open' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE "accounts_bank_balances" ADD CONSTRAINT "accounts_bank_balances_item_id_accounts_bank_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_bank_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_bank_balances" ADD CONSTRAINT "accounts_bank_balances_week_id_accounts_bank_weeks_id_fk" FOREIGN KEY ("week_id") REFERENCES "public"."accounts_bank_weeks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_bank_balances" ADD CONSTRAINT "accounts_bank_balances_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_bank_items" ADD CONSTRAINT "accounts_bank_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_bank_weeks" ADD CONSTRAINT "accounts_bank_weeks_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_cash_items" ADD CONSTRAINT "accounts_cash_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_cash_limits" ADD CONSTRAINT "accounts_cash_limits_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_cash_months" ADD CONSTRAINT "accounts_cash_months_item_id_accounts_cash_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_cash_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_cash_months" ADD CONSTRAINT "accounts_cash_months_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_cc_cards" ADD CONSTRAINT "accounts_cc_cards_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_cc_months" ADD CONSTRAINT "accounts_cc_months_card_id_accounts_cc_cards_id_fk" FOREIGN KEY ("card_id") REFERENCES "public"."accounts_cc_cards"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_cc_months" ADD CONSTRAINT "accounts_cc_months_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_due_items" ADD CONSTRAINT "accounts_due_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_fno_items" ADD CONSTRAINT "accounts_fno_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_fno_months" ADD CONSTRAINT "accounts_fno_months_item_id_accounts_fno_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_fno_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_fno_months" ADD CONSTRAINT "accounts_fno_months_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_it_folders" ADD CONSTRAINT "accounts_it_folders_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_loan_cells" ADD CONSTRAINT "accounts_loan_cells_loan_id_accounts_loan_items_id_fk" FOREIGN KEY ("loan_id") REFERENCES "public"."accounts_loan_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_loan_cells" ADD CONSTRAINT "accounts_loan_cells_period_id_accounts_loan_periods_id_fk" FOREIGN KEY ("period_id") REFERENCES "public"."accounts_loan_periods"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_loan_cells" ADD CONSTRAINT "accounts_loan_cells_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_loan_items" ADD CONSTRAINT "accounts_loan_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_loan_periods" ADD CONSTRAINT "accounts_loan_periods_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_monthly_checks" ADD CONSTRAINT "accounts_monthly_checks_item_id_accounts_monthly_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_monthly_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_monthly_checks" ADD CONSTRAINT "accounts_monthly_checks_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_monthly_items" ADD CONSTRAINT "accounts_monthly_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_shares" ADD CONSTRAINT "accounts_shares_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_sip_items" ADD CONSTRAINT "accounts_sip_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_sip_months" ADD CONSTRAINT "accounts_sip_months_item_id_accounts_sip_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_sip_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_sip_months" ADD CONSTRAINT "accounts_sip_months_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_task_list" ADD CONSTRAINT "accounts_task_list_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_vasa_balances" ADD CONSTRAINT "accounts_vasa_balances_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_weekly_checks" ADD CONSTRAINT "accounts_weekly_checks_item_id_accounts_weekly_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."accounts_weekly_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "accounts_weekly_checks" ADD CONSTRAINT "accounts_weekly_checks_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "accounts_weekly_items" ADD CONSTRAINT "accounts_weekly_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "achievements_earned" ADD CONSTRAINT "achievements_earned_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "agreements" ADD CONSTRAINT "agreements_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "agreements" ADD CONSTRAINT "agreements_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "ai_usage" ADD CONSTRAINT "ai_usage_user_id_employees_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_activities" ADD CONSTRAINT "amb_activities_ambassador_id_amb_ambassadors_id_fk" FOREIGN KEY ("ambassador_id") REFERENCES "public"."amb_ambassadors"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_activities" ADD CONSTRAINT "amb_activities_referral_id_amb_referrals_id_fk" FOREIGN KEY ("referral_id") REFERENCES "public"."amb_referrals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_activities" ADD CONSTRAINT "amb_activities_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_ambassador_products" ADD CONSTRAINT "amb_ambassador_products_ambassador_id_amb_ambassadors_id_fk" FOREIGN KEY ("ambassador_id") REFERENCES "public"."amb_ambassadors"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_ambassador_products" ADD CONSTRAINT "amb_ambassador_products_product_id_amb_products_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."amb_products"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_ambassadors" ADD CONSTRAINT "amb_ambassadors_owner_id_employees_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_ambassadors" ADD CONSTRAINT "amb_ambassadors_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_documents" ADD CONSTRAINT "amb_documents_ambassador_id_amb_ambassadors_id_fk" FOREIGN KEY ("ambassador_id") REFERENCES "public"."amb_ambassadors"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_documents" ADD CONSTRAINT "amb_documents_supersedes_id_amb_documents_id_fk" FOREIGN KEY ("supersedes_id") REFERENCES "public"."amb_documents"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_documents" ADD CONSTRAINT "amb_documents_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_payout_referrals" ADD CONSTRAINT "amb_payout_referrals_payout_id_amb_payouts_id_fk" FOREIGN KEY ("payout_id") REFERENCES "public"."amb_payouts"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_payout_referrals" ADD CONSTRAINT "amb_payout_referrals_referral_id_amb_referrals_id_fk" FOREIGN KEY ("referral_id") REFERENCES "public"."amb_referrals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_payouts" ADD CONSTRAINT "amb_payouts_ambassador_id_amb_ambassadors_id_fk" FOREIGN KEY ("ambassador_id") REFERENCES "public"."amb_ambassadors"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_payouts" ADD CONSTRAINT "amb_payouts_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_ambassador_id_amb_ambassadors_id_fk" FOREIGN KEY ("ambassador_id") REFERENCES "public"."amb_ambassadors"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_assigned_to_id_employees_id_fk" FOREIGN KEY ("assigned_to_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_product_id_amb_products_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."amb_products"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_client_id_clients_id_fk" FOREIGN KEY ("client_id") REFERENCES "public"."clients"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_pg_introduction_id_pg_introductions_id_fk" FOREIGN KEY ("pg_introduction_id") REFERENCES "public"."pg_introductions"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "amb_referrals" ADD CONSTRAINT "amb_referrals_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_attitude" ADD CONSTRAINT "appr_attitude_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_config" ADD CONSTRAINT "appr_config_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_config" ADD CONSTRAINT "appr_config_manager_id_employees_id_fk" FOREIGN KEY ("manager_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_config" ADD CONSTRAINT "appr_config_management_id_employees_id_fk" FOREIGN KEY ("management_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_config" ADD CONSTRAINT "appr_config_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_dimension_score" ADD CONSTRAINT "appr_dimension_score_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_dimension_score" ADD CONSTRAINT "appr_dimension_score_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_item_score" ADD CONSTRAINT "appr_item_score_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_item_score" ADD CONSTRAINT "appr_item_score_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_kpi" ADD CONSTRAINT "appr_kpi_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_kpi" ADD CONSTRAINT "appr_kpi_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_scorecard" ADD CONSTRAINT "appr_scorecard_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_scorecard" ADD CONSTRAINT "appr_scorecard_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appr_skill" ADD CONSTRAINT "appr_skill_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appr_skill" ADD CONSTRAINT "appr_skill_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_attachments" ADD CONSTRAINT "appraisal_attachments_item_id_appraisal_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."appraisal_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appraisal_attachments" ADD CONSTRAINT "appraisal_attachments_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_config" ADD CONSTRAINT "appraisal_config_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_culture_assignments" ADD CONSTRAINT "appraisal_culture_assignments_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_cycles" ADD CONSTRAINT "appraisal_cycles_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_items" ADD CONSTRAINT "appraisal_items_cycle_id_appraisal_cycles_id_fk" FOREIGN KEY ("cycle_id") REFERENCES "public"."appraisal_cycles"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appraisal_items" ADD CONSTRAINT "appraisal_items_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appraisal_items" ADD CONSTRAINT "appraisal_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_scores" ADD CONSTRAINT "appraisal_scores_item_id_appraisal_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."appraisal_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "appraisal_scores" ADD CONSTRAINT "appraisal_scores_manager_id_employees_id_fk" FOREIGN KEY ("manager_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_scores" ADD CONSTRAINT "appraisal_scores_management_id_employees_id_fk" FOREIGN KEY ("management_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "appraisal_scores" ADD CONSTRAINT "appraisal_scores_finalized_by_id_employees_id_fk" FOREIGN KEY ("finalized_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "approval_tokens" ADD CONSTRAINT "approval_tokens_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "attendance_discipline_notes" ADD CONSTRAINT "attendance_discipline_notes_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "attendance_discipline_notes" ADD CONSTRAINT "attendance_discipline_notes_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "attendance_logs" ADD CONSTRAINT "attendance_logs_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "attendance_logs" ADD CONSTRAINT "attendance_logs_recorded_by_id_employees_id_fk" FOREIGN KEY ("recorded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "attendance_month_freeze" ADD CONSTRAINT "attendance_month_freeze_frozen_by_id_employees_id_fk" FOREIGN KEY ("frozen_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "attendance_sheet_day" ADD CONSTRAINT "attendance_sheet_day_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "attendance_sheet_month" ADD CONSTRAINT "attendance_sheet_month_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "audit_data_exports" ADD CONSTRAINT "audit_data_exports_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "auth_sessions" ADD CONSTRAINT "auth_sessions_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "broadcast_poll_responses" ADD CONSTRAINT "broadcast_poll_responses_broadcast_id_broadcasts_id_fk" FOREIGN KEY ("broadcast_id") REFERENCES "public"."broadcasts"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "broadcast_poll_responses" ADD CONSTRAINT "broadcast_poll_responses_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "broadcast_recipients" ADD CONSTRAINT "broadcast_recipients_broadcast_id_broadcasts_id_fk" FOREIGN KEY ("broadcast_id") REFERENCES "public"."broadcasts"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "broadcast_recipients" ADD CONSTRAINT "broadcast_recipients_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "broadcast_segments" ADD CONSTRAINT "broadcast_segments_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "broadcast_templates" ADD CONSTRAINT "broadcast_templates_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "broadcasts" ADD CONSTRAINT "broadcasts_author_id_employees_id_fk" FOREIGN KEY ("author_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "calendar_events" ADD CONSTRAINT "calendar_events_category_id_event_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."event_categories"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "calendar_events" ADD CONSTRAINT "calendar_events_obligation_id_obligations_id_fk" FOREIGN KEY ("obligation_id") REFERENCES "public"."obligations"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "calendar_events" ADD CONSTRAINT "calendar_events_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "calendar_events" ADD CONSTRAINT "calendar_events_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "candidate_intake" ADD CONSTRAINT "candidate_intake_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "comp_off_credits" ADD CONSTRAINT "comp_off_credits_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "comp_off_credits" ADD CONSTRAINT "comp_off_credits_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "ctc_breakups" ADD CONSTRAINT "ctc_breakups_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "ctc_breakups" ADD CONSTRAINT "ctc_breakups_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "daily_checklist" ADD CONSTRAINT "daily_checklist_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "daily_checklist" ADD CONSTRAINT "daily_checklist_goal_id_weekly_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "daily_checklist" ADD CONSTRAINT "daily_checklist_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "daily_checklist" ADD CONSTRAINT "daily_checklist_cascade_goal_id_goals_id_fk" FOREIGN KEY ("cascade_goal_id") REFERENCES "public"."goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "daily_checklist_reviews" ADD CONSTRAINT "daily_checklist_reviews_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "daily_checklist_reviews" ADD CONSTRAINT "daily_checklist_reviews_reviewer_id_employees_id_fk" FOREIGN KEY ("reviewer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "daily_plan_day" ADD CONSTRAINT "daily_plan_day_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_clients" ADD CONSTRAINT "dcc_clients_owner_employee_id_employees_id_fk" FOREIGN KEY ("owner_employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_entries" ADD CONSTRAINT "dcc_entries_item_id_dcc_kpi_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."dcc_kpi_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_entries" ADD CONSTRAINT "dcc_entries_filled_by_id_employees_id_fk" FOREIGN KEY ("filled_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "dcc_entries" ADD CONSTRAINT "dcc_entries_subject_id_dcc_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."dcc_subjects"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_item_subjects" ADD CONSTRAINT "dcc_item_subjects_item_id_dcc_kpi_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."dcc_kpi_items"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_item_subjects" ADD CONSTRAINT "dcc_item_subjects_subject_id_dcc_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."dcc_subjects"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_kpi_items" ADD CONSTRAINT "dcc_kpi_items_owner_employee_id_employees_id_fk" FOREIGN KEY ("owner_employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_kpi_items" ADD CONSTRAINT "dcc_kpi_items_client_id_dcc_clients_id_fk" FOREIGN KEY ("client_id") REFERENCES "public"."dcc_clients"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_kpi_items" ADD CONSTRAINT "dcc_kpi_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "dcc_reviews" ADD CONSTRAINT "dcc_reviews_owner_employee_id_employees_id_fk" FOREIGN KEY ("owner_employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "dcc_reviews" ADD CONSTRAINT "dcc_reviews_reviewer_id_employees_id_fk" FOREIGN KEY ("reviewer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "dcc_subjects" ADD CONSTRAINT "dcc_subjects_owner_employee_id_employees_id_fk" FOREIGN KEY ("owner_employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "device_push_tokens" ADD CONSTRAINT "device_push_tokens_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "document_events" ADD CONSTRAINT "document_events_document_id_documents_id_fk" FOREIGN KEY ("document_id") REFERENCES "public"."documents"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "document_events" ADD CONSTRAINT "document_events_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "document_instances" ADD CONSTRAINT "document_instances_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "document_instances" ADD CONSTRAINT "document_instances_issued_by_id_employees_id_fk" FOREIGN KEY ("issued_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "document_signatures" ADD CONSTRAINT "document_signatures_signer_employee_id_employees_id_fk" FOREIGN KEY ("signer_employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "document_signatures" ADD CONSTRAINT "document_signatures_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "documents" ADD CONSTRAINT "documents_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "documents" ADD CONSTRAINT "documents_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "documents" ADD CONSTRAINT "documents_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "documents" ADD CONSTRAINT "documents_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employee_departments" ADD CONSTRAINT "employee_departments_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "employee_departments" ADD CONSTRAINT "employee_departments_department_id_departments_id_fk" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "employee_documents" ADD CONSTRAINT "employee_documents_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "employee_documents" ADD CONSTRAINT "employee_documents_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employee_events" ADD CONSTRAINT "employee_events_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "employee_events" ADD CONSTRAINT "employee_events_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "employees" ADD CONSTRAINT "employees_department_id_departments_id_fk" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employees" ADD CONSTRAINT "employees_ooo_delegate_id_employees_id_fk" FOREIGN KEY ("ooo_delegate_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employees" ADD CONSTRAINT "employees_manager_id_employees_id_fk" FOREIGN KEY ("manager_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employees" ADD CONSTRAINT "employees_designation_id_designations_id_fk" FOREIGN KEY ("designation_id") REFERENCES "public"."designations"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "employees" ADD CONSTRAINT "employees_paying_entity_id_paying_entities_id_fk" FOREIGN KEY ("paying_entity_id") REFERENCES "public"."paying_entities"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "evaluation_weight_profiles" ADD CONSTRAINT "evaluation_weight_profiles_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_schedules" ADD CONSTRAINT "event_batch_schedules_batch_type_id_event_batch_types_id_fk" FOREIGN KEY ("batch_type_id") REFERENCES "public"."event_batch_types"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "event_batch_schedules" ADD CONSTRAINT "event_batch_schedules_category_id_event_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."event_categories"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_schedules" ADD CONSTRAINT "event_batch_schedules_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_schedules" ADD CONSTRAINT "event_batch_schedules_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_types" ADD CONSTRAINT "event_batch_types_default_category_id_event_categories_id_fk" FOREIGN KEY ("default_category_id") REFERENCES "public"."event_categories"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_types" ADD CONSTRAINT "event_batch_types_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_batch_types" ADD CONSTRAINT "event_batch_types_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_categories" ADD CONSTRAINT "event_categories_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_categories" ADD CONSTRAINT "event_categories_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_holidays" ADD CONSTRAINT "event_holidays_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "event_holidays" ADD CONSTRAINT "event_holidays_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "form_configs" ADD CONSTRAINT "form_configs_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goal_ai_insights" ADD CONSTRAINT "goal_ai_insights_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_ai_insights" ADD CONSTRAINT "goal_ai_insights_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_capture_log" ADD CONSTRAINT "goal_capture_log_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_comments" ADD CONSTRAINT "goal_comments_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_comments" ADD CONSTRAINT "goal_comments_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_comments" ADD CONSTRAINT "goal_comments_parent_id_goal_comments_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."goal_comments"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_comments" ADD CONSTRAINT "goal_comments_author_id_employees_id_fk" FOREIGN KEY ("author_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goal_dependencies" ADD CONSTRAINT "goal_dependencies_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_dependencies" ADD CONSTRAINT "goal_dependencies_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_dependencies" ADD CONSTRAINT "goal_dependencies_on_goal_id_goals_id_fk" FOREIGN KEY ("on_goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_dependencies" ADD CONSTRAINT "goal_dependencies_on_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("on_weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_dependencies" ADD CONSTRAINT "goal_dependencies_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goal_links" ADD CONSTRAINT "goal_links_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_links" ADD CONSTRAINT "goal_links_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_links" ADD CONSTRAINT "goal_links_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goal_lookups" ADD CONSTRAINT "goal_lookups_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goal_reviews" ADD CONSTRAINT "goal_reviews_goal_id_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_reviews" ADD CONSTRAINT "goal_reviews_weekly_goal_id_weekly_goals_id_fk" FOREIGN KEY ("weekly_goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goal_reviews" ADD CONSTRAINT "goal_reviews_reviewer_id_employees_id_fk" FOREIGN KEY ("reviewer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_parent_goal_id_goals_id_fk" FOREIGN KEY ("parent_goal_id") REFERENCES "public"."goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_cloned_from_id_goals_id_fk" FOREIGN KEY ("cloned_from_id") REFERENCES "public"."goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_reviewed_by_id_employees_id_fk" FOREIGN KEY ("reviewed_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "goals" ADD CONSTRAINT "goals_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "holidays" ADD CONSTRAINT "holidays_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "hr_confirmation_reminders" ADD CONSTRAINT "hr_confirmation_reminders_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "hr_ticket_attachments" ADD CONSTRAINT "hr_ticket_attachments_ticket_id_hr_tickets_id_fk" FOREIGN KEY ("ticket_id") REFERENCES "public"."hr_tickets"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "hr_ticket_attachments" ADD CONSTRAINT "hr_ticket_attachments_message_id_hr_ticket_messages_id_fk" FOREIGN KEY ("message_id") REFERENCES "public"."hr_ticket_messages"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "hr_ticket_attachments" ADD CONSTRAINT "hr_ticket_attachments_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "hr_ticket_messages" ADD CONSTRAINT "hr_ticket_messages_ticket_id_hr_tickets_id_fk" FOREIGN KEY ("ticket_id") REFERENCES "public"."hr_tickets"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "hr_ticket_messages" ADD CONSTRAINT "hr_ticket_messages_author_id_employees_id_fk" FOREIGN KEY ("author_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "hr_ticket_routes" ADD CONSTRAINT "hr_ticket_routes_owner_id_employees_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "hr_ticket_routes" ADD CONSTRAINT "hr_ticket_routes_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "hr_tickets" ADD CONSTRAINT "hr_tickets_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "hr_tickets" ADD CONSTRAINT "hr_tickets_assignee_id_employees_id_fk" FOREIGN KEY ("assignee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_config" ADD CONSTRAINT "incentive_config_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_entries" ADD CONSTRAINT "incentive_entries_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_entries" ADD CONSTRAINT "incentive_entries_payout_run_id_salary_runs_id_fk" FOREIGN KEY ("payout_run_id") REFERENCES "public"."salary_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_entries" ADD CONSTRAINT "incentive_entries_paid_by_id_employees_id_fk" FOREIGN KEY ("paid_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_participants" ADD CONSTRAINT "incentive_participants_entry_id_incentive_entries_id_fk" FOREIGN KEY ("entry_id") REFERENCES "public"."incentive_entries"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "incentive_participants" ADD CONSTRAINT "incentive_participants_project_id_incentive_projects_id_fk" FOREIGN KEY ("project_id") REFERENCES "public"."incentive_projects"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "incentive_participants" ADD CONSTRAINT "incentive_participants_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_participants" ADD CONSTRAINT "incentive_participants_payout_run_id_salary_runs_id_fk" FOREIGN KEY ("payout_run_id") REFERENCES "public"."salary_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_payout_events" ADD CONSTRAINT "incentive_payout_events_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_payout_events" ADD CONSTRAINT "incentive_payout_events_salary_run_id_salary_runs_id_fk" FOREIGN KEY ("salary_run_id") REFERENCES "public"."salary_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_payout_events" ADD CONSTRAINT "incentive_payout_events_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_projects" ADD CONSTRAINT "incentive_projects_supervisor_id_employees_id_fk" FOREIGN KEY ("supervisor_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_projects" ADD CONSTRAINT "incentive_projects_intern_id_employees_id_fk" FOREIGN KEY ("intern_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_projects" ADD CONSTRAINT "incentive_projects_payout_run_id_salary_runs_id_fk" FOREIGN KEY ("payout_run_id") REFERENCES "public"."salary_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_requests" ADD CONSTRAINT "incentive_requests_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "incentive_requests" ADD CONSTRAINT "incentive_requests_decided_by_id_employees_id_fk" FOREIGN KEY ("decided_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "incentive_targets" ADD CONSTRAINT "incentive_targets_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "index_links" ADD CONSTRAINT "index_links_section_id_index_sections_id_fk" FOREIGN KEY ("section_id") REFERENCES "public"."index_sections"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "kpi_assignment_history" ADD CONSTRAINT "kpi_assignment_history_assignment_id_kpi_assignments_id_fk" FOREIGN KEY ("assignment_id") REFERENCES "public"."kpi_assignments"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "kpi_assignment_history" ADD CONSTRAINT "kpi_assignment_history_changed_by_id_employees_id_fk" FOREIGN KEY ("changed_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "kpi_assignments" ADD CONSTRAINT "kpi_assignments_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "kpi_assignments" ADD CONSTRAINT "kpi_assignments_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "kpi_assignments" ADD CONSTRAINT "kpi_assignments_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_decided_by_id_employees_id_fk" FOREIGN KEY ("decided_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "letter_templates" ADD CONSTRAINT "letter_templates_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "mobile_devices" ADD CONSTRAINT "mobile_devices_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "module_submissions" ADD CONSTRAINT "module_submissions_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "module_submissions" ADD CONSTRAINT "module_submissions_decided_by_id_employees_id_fk" FOREIGN KEY ("decided_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "notification_dispatch_log" ADD CONSTRAINT "notification_dispatch_log_notification_id_notifications_id_fk" FOREIGN KEY ("notification_id") REFERENCES "public"."notifications"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "notification_preferences" ADD CONSTRAINT "notification_preferences_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_employees_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_event_id_task_events_id_fk" FOREIGN KEY ("event_id") REFERENCES "public"."task_events"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "obligation_completions" ADD CONSTRAINT "obligation_completions_obligation_id_obligations_id_fk" FOREIGN KEY ("obligation_id") REFERENCES "public"."obligations"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "obligation_completions" ADD CONSTRAINT "obligation_completions_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "obligation_completions" ADD CONSTRAINT "obligation_completions_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "obligations" ADD CONSTRAINT "obligations_category_id_event_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."event_categories"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "obligations" ADD CONSTRAINT "obligations_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "obligations" ADD CONSTRAINT "obligations_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "onboarding_submissions" ADD CONSTRAINT "onboarding_submissions_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "onboarding_submissions" ADD CONSTRAINT "onboarding_submissions_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "onboarding_submissions" ADD CONSTRAINT "onboarding_submissions_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "org_settings" ADD CONSTRAINT "org_settings_hr_assignment_owner_id_employees_id_fk" FOREIGN KEY ("hr_assignment_owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "org_settings" ADD CONSTRAINT "org_settings_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_attachments" ADD CONSTRAINT "outstanding_attachments_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_collections" ADD CONSTRAINT "outstanding_collections_contract_id_outstanding_contracts_id_fk" FOREIGN KEY ("contract_id") REFERENCES "public"."outstanding_contracts"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_collections" ADD CONSTRAINT "outstanding_collections_payment_mode_id_outstanding_payment_modes_id_fk" FOREIGN KEY ("payment_mode_id") REFERENCES "public"."outstanding_payment_modes"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_collections" ADD CONSTRAINT "outstanding_collections_responsible_id_outstanding_responsibles_id_fk" FOREIGN KEY ("responsible_id") REFERENCES "public"."outstanding_responsibles"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_collections" ADD CONSTRAINT "outstanding_collections_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_contracts" ADD CONSTRAINT "outstanding_contracts_product_id_outstanding_products_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."outstanding_products"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_contracts" ADD CONSTRAINT "outstanding_contracts_entity_id_outstanding_entities_id_fk" FOREIGN KEY ("entity_id") REFERENCES "public"."outstanding_entities"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_contracts" ADD CONSTRAINT "outstanding_contracts_responsible_id_outstanding_responsibles_id_fk" FOREIGN KEY ("responsible_id") REFERENCES "public"."outstanding_responsibles"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_contracts" ADD CONSTRAINT "outstanding_contracts_expected_mode_id_outstanding_payment_modes_id_fk" FOREIGN KEY ("expected_mode_id") REFERENCES "public"."outstanding_payment_modes"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_contracts" ADD CONSTRAINT "outstanding_contracts_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_entries" ADD CONSTRAINT "outstanding_entries_owner_id_employees_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_entries" ADD CONSTRAINT "outstanding_entries_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "outstanding_followups" ADD CONSTRAINT "outstanding_followups_entry_id_outstanding_entries_id_fk" FOREIGN KEY ("entry_id") REFERENCES "public"."outstanding_entries"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "outstanding_followups" ADD CONSTRAINT "outstanding_followups_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "outstanding_installments" ADD CONSTRAINT "outstanding_installments_contract_id_outstanding_contracts_id_fk" FOREIGN KEY ("contract_id") REFERENCES "public"."outstanding_contracts"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "overtime_entries" ADD CONSTRAINT "overtime_entries_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "overtime_entries" ADD CONSTRAINT "overtime_entries_approved_by_id_employees_id_fk" FOREIGN KEY ("approved_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "overtime_entries" ADD CONSTRAINT "overtime_entries_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "paid_leave_cycle" ADD CONSTRAINT "paid_leave_cycle_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "performance_scorecards" ADD CONSTRAINT "performance_scorecards_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "performance_scorecards" ADD CONSTRAINT "performance_scorecards_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pg_introductions" ADD CONSTRAINT "pg_introductions_reference_source_id_pg_reference_sources_id_fk" FOREIGN KEY ("reference_source_id") REFERENCES "public"."pg_reference_sources"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pg_introductions" ADD CONSTRAINT "pg_introductions_designation_id_pg_designations_id_fk" FOREIGN KEY ("designation_id") REFERENCES "public"."pg_designations"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pg_introductions" ADD CONSTRAINT "pg_introductions_business_category_id_pg_business_categories_id_fk" FOREIGN KEY ("business_category_id") REFERENCES "public"."pg_business_categories"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pg_introductions" ADD CONSTRAINT "pg_introductions_sales_person_id_pg_sales_people_id_fk" FOREIGN KEY ("sales_person_id") REFERENCES "public"."pg_sales_people"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pg_introductions" ADD CONSTRAINT "pg_introductions_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pinned_items" ADD CONSTRAINT "pinned_items_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_monthly_review" ADD CONSTRAINT "pms_monthly_review_subject_id_employees_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_monthly_review" ADD CONSTRAINT "pms_monthly_review_reviewer_id_employees_id_fk" FOREIGN KEY ("reviewer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pms_personal_goal" ADD CONSTRAINT "pms_personal_goal_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_promotion_signal" ADD CONSTRAINT "pms_promotion_signal_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_promotion_signal" ADD CONSTRAINT "pms_promotion_signal_decided_by_id_employees_id_fk" FOREIGN KEY ("decided_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pms_recognition" ADD CONSTRAINT "pms_recognition_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_recognition" ADD CONSTRAINT "pms_recognition_released_by_id_employees_id_fk" FOREIGN KEY ("released_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pms_review" ADD CONSTRAINT "pms_review_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "pms_review" ADD CONSTRAINT "pms_review_reviewer_id_employees_id_fk" FOREIGN KEY ("reviewer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "pms_score_config" ADD CONSTRAINT "pms_score_config_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "policy_compliance" ADD CONSTRAINT "policy_compliance_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "policy_documents" ADD CONSTRAINT "policy_documents_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "policy_versions" ADD CONSTRAINT "policy_versions_published_by_id_employees_id_fk" FOREIGN KEY ("published_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "project_members" ADD CONSTRAINT "project_members_project_node_id_project_nodes_id_fk" FOREIGN KEY ("project_node_id") REFERENCES "public"."project_nodes"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "project_members" ADD CONSTRAINT "project_members_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "project_nodes" ADD CONSTRAINT "project_nodes_owner_id_employees_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "project_nodes" ADD CONSTRAINT "project_nodes_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "push_subscriptions" ADD CONSTRAINT "push_subscriptions_user_id_employees_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "rev_agent_audit" ADD CONSTRAINT "rev_agent_audit_run_id_rev_agent_runs_id_fk" FOREIGN KEY ("run_id") REFERENCES "public"."rev_agent_runs"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "rev_agent_audit" ADD CONSTRAINT "rev_agent_audit_user_id_employees_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_agent_runs" ADD CONSTRAINT "rev_agent_runs_user_id_employees_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_campaigns" ADD CONSTRAINT "rev_campaigns_host_id_employees_id_fk" FOREIGN KEY ("host_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_drafts" ADD CONSTRAINT "rev_drafts_lead_id_rev_leads_id_fk" FOREIGN KEY ("lead_id") REFERENCES "public"."rev_leads"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_drafts" ADD CONSTRAINT "rev_drafts_created_by_run_rev_agent_runs_id_fk" FOREIGN KEY ("created_by_run") REFERENCES "public"."rev_agent_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_drafts" ADD CONSTRAINT "rev_drafts_approved_by_employees_id_fk" FOREIGN KEY ("approved_by") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_lead_events" ADD CONSTRAINT "rev_lead_events_lead_id_rev_leads_id_fk" FOREIGN KEY ("lead_id") REFERENCES "public"."rev_leads"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "rev_leads" ADD CONSTRAINT "rev_leads_owner_id_employees_id_fk" FOREIGN KEY ("owner_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "rev_leads" ADD CONSTRAINT "rev_leads_created_by_employees_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_advances" ADD CONSTRAINT "salary_advances_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "salary_advances" ADD CONSTRAINT "salary_advances_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_breakup" ADD CONSTRAINT "salary_breakup_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_breakup" ADD CONSTRAINT "salary_breakup_paid_by_id_employees_id_fk" FOREIGN KEY ("paid_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_breakup" ADD CONSTRAINT "salary_breakup_admin_note_by_id_employees_id_fk" FOREIGN KEY ("admin_note_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_breakup" ADD CONSTRAINT "salary_breakup_waive_off_by_id_employees_id_fk" FOREIGN KEY ("waive_off_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_breakup" ADD CONSTRAINT "salary_breakup_payout_adjustment_by_id_employees_id_fk" FOREIGN KEY ("payout_adjustment_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_config" ADD CONSTRAINT "salary_config_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_salary_run_id_salary_runs_id_fk" FOREIGN KEY ("salary_run_id") REFERENCES "public"."salary_runs"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_incentive_entry_id_incentive_entries_id_fk" FOREIGN KEY ("incentive_entry_id") REFERENCES "public"."incentive_entries"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_payments" ADD CONSTRAINT "salary_payments_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_policies" ADD CONSTRAINT "salary_policies_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_policy_consents" ADD CONSTRAINT "salary_policy_consents_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "salary_profiles" ADD CONSTRAINT "salary_profiles_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "salary_runs" ADD CONSTRAINT "salary_runs_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "salary_runs" ADD CONSTRAINT "salary_runs_approved_by_id_employees_id_fk" FOREIGN KEY ("approved_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "salary_runs" ADD CONSTRAINT "salary_runs_generated_by_id_employees_id_fk" FOREIGN KEY ("generated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "settings_events" ADD CONSTRAINT "settings_events_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "skill_lookups" ADD CONSTRAINT "skill_lookups_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "status_settings" ADD CONSTRAINT "status_settings_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "sync_runs" ADD CONSTRAINT "sync_runs_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "task_attachments" ADD CONSTRAINT "task_attachments_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_attachments" ADD CONSTRAINT "task_attachments_uploaded_by_id_employees_id_fk" FOREIGN KEY ("uploaded_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "task_checklist_items" ADD CONSTRAINT "task_checklist_items_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_checklist_items" ADD CONSTRAINT "task_checklist_items_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "task_checklist_items" ADD CONSTRAINT "task_checklist_items_done_by_id_employees_id_fk" FOREIGN KEY ("done_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "task_events" ADD CONSTRAINT "task_events_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_events" ADD CONSTRAINT "task_events_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "task_time_consent" ADD CONSTRAINT "task_time_consent_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_time_events" ADD CONSTRAINT "task_time_events_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_time_events" ADD CONSTRAINT "task_time_events_actor_id_employees_id_fk" FOREIGN KEY ("actor_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "task_time_events" ADD CONSTRAINT "task_time_events_doer_id_employees_id_fk" FOREIGN KEY ("doer_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "task_time_rollup" ADD CONSTRAINT "task_time_rollup_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_work_sessions" ADD CONSTRAINT "task_work_sessions_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_work_sessions" ADD CONSTRAINT "task_work_sessions_doer_id_employees_id_fk" FOREIGN KEY ("doer_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "task_work_snapshots" ADD CONSTRAINT "task_work_snapshots_session_id_task_work_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."task_work_sessions"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_work_snapshots" ADD CONSTRAINT "task_work_snapshots_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "task_work_snapshots" ADD CONSTRAINT "task_work_snapshots_doer_id_employees_id_fk" FOREIGN KEY ("doer_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_doer_id_employees_id_fk" FOREIGN KEY ("doer_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_initiator_id_employees_id_fk" FOREIGN KEY ("initiator_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_transferred_from_id_employees_id_fk" FOREIGN KEY ("transferred_from_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_abandoned_by_id_employees_id_fk" FOREIGN KEY ("abandoned_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE restrict ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_approved_by_id_employees_id_fk" FOREIGN KEY ("approved_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_project_node_id_project_nodes_id_fk" FOREIGN KEY ("project_node_id") REFERENCES "public"."project_nodes"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_assessments" ADD CONSTRAINT "tc_assessments_session_id_tc_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."tc_sessions"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_assessments" ADD CONSTRAINT "tc_assessments_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_assessments" ADD CONSTRAINT "tc_assessments_waived_by_id_employees_id_fk" FOREIGN KEY ("waived_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_assessments" ADD CONSTRAINT "tc_assessments_assessed_by_id_employees_id_fk" FOREIGN KEY ("assessed_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_attempts" ADD CONSTRAINT "tc_attempts_test_id_tc_tests_id_fk" FOREIGN KEY ("test_id") REFERENCES "public"."tc_tests"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_attempts" ADD CONSTRAINT "tc_attempts_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_feedback" ADD CONSTRAINT "tc_feedback_rated_employee_id_employees_id_fk" FOREIGN KEY ("rated_employee_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_feedback" ADD CONSTRAINT "tc_feedback_service_id_tc_services_id_fk" FOREIGN KEY ("service_id") REFERENCES "public"."tc_services"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_feedback" ADD CONSTRAINT "tc_feedback_escalated_to_id_employees_id_fk" FOREIGN KEY ("escalated_to_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_feedback" ADD CONSTRAINT "tc_feedback_signed_off_by_id_employees_id_fk" FOREIGN KEY ("signed_off_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_feedback" ADD CONSTRAINT "tc_feedback_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_materials" ADD CONSTRAINT "tc_materials_subject_id_tc_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."tc_subjects"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_materials" ADD CONSTRAINT "tc_materials_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_questions" ADD CONSTRAINT "tc_questions_test_id_tc_tests_id_fk" FOREIGN KEY ("test_id") REFERENCES "public"."tc_tests"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_self_learning" ADD CONSTRAINT "tc_self_learning_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_session_attendees" ADD CONSTRAINT "tc_session_attendees_session_id_tc_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."tc_sessions"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_session_attendees" ADD CONSTRAINT "tc_session_attendees_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_session_attendees" ADD CONSTRAINT "tc_session_attendees_marked_by_id_employees_id_fk" FOREIGN KEY ("marked_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_session_feedback" ADD CONSTRAINT "tc_session_feedback_session_id_tc_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."tc_sessions"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_session_feedback" ADD CONSTRAINT "tc_session_feedback_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_sessions" ADD CONSTRAINT "tc_sessions_subject_id_tc_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."tc_subjects"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_sessions" ADD CONSTRAINT "tc_sessions_trainer_id_employees_id_fk" FOREIGN KEY ("trainer_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_sessions" ADD CONSTRAINT "tc_sessions_material_id_tc_materials_id_fk" FOREIGN KEY ("material_id") REFERENCES "public"."tc_materials"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_sessions" ADD CONSTRAINT "tc_sessions_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "tc_share_feedback" ADD CONSTRAINT "tc_share_feedback_share_id_tc_shares_id_fk" FOREIGN KEY ("share_id") REFERENCES "public"."tc_shares"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_share_feedback" ADD CONSTRAINT "tc_share_feedback_rater_id_employees_id_fk" FOREIGN KEY ("rater_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_shares" ADD CONSTRAINT "tc_shares_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_tests" ADD CONSTRAINT "tc_tests_material_id_tc_materials_id_fk" FOREIGN KEY ("material_id") REFERENCES "public"."tc_materials"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_watch_progress" ADD CONSTRAINT "tc_watch_progress_material_id_tc_materials_id_fk" FOREIGN KEY ("material_id") REFERENCES "public"."tc_materials"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "tc_watch_progress" ADD CONSTRAINT "tc_watch_progress_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "webauthn_credentials" ADD CONSTRAINT "webauthn_credentials_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "weekly_goal_actuals" ADD CONSTRAINT "weekly_goal_actuals_goal_id_weekly_goals_id_fk" FOREIGN KEY ("goal_id") REFERENCES "public"."weekly_goals"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "weekly_goal_actuals" ADD CONSTRAINT "weekly_goal_actuals_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "weekly_goal_actuals" ADD CONSTRAINT "weekly_goal_actuals_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_pct_updated_by_id_employees_id_fk" FOREIGN KEY ("pct_updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_reviewed_by_id_employees_id_fk" FOREIGN KEY ("reviewed_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_task_id_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."tasks"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_month_goal_id_goals_id_fk" FOREIGN KEY ("month_goal_id") REFERENCES "public"."goals"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_created_by_id_employees_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "weekly_goals" ADD CONSTRAINT "weekly_goals_updated_by_id_employees_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."employees"("id") ON DELETE set null ON UPDATE no action;
ALTER TABLE "work_session_shots" ADD CONSTRAINT "work_session_shots_session_id_work_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."work_sessions"("id") ON DELETE cascade ON UPDATE no action;
ALTER TABLE "work_sessions" ADD CONSTRAINT "work_sessions_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE no action;
CREATE UNIQUE INDEX "accounts_bank_balances_uq" ON "accounts_bank_balances" USING btree ("item_id","week_id");
CREATE INDEX "accounts_bank_items_fy_sort_idx" ON "accounts_bank_items" USING btree ("fy_start_year","sort_order");
CREATE INDEX "accounts_bank_weeks_fy_sort_idx" ON "accounts_bank_weeks" USING btree ("fy_start_year","sort_order");
CREATE INDEX "accounts_cash_items_fy_sort_idx" ON "accounts_cash_items" USING btree ("fy_start_year","sort_order");
CREATE UNIQUE INDEX "accounts_cash_limits_fy_entity_uq" ON "accounts_cash_limits" USING btree ("fy_start_year","entity");
CREATE UNIQUE INDEX "accounts_cash_months_uq" ON "accounts_cash_months" USING btree ("item_id","month");
CREATE INDEX "accounts_cc_cards_fy_sort_idx" ON "accounts_cc_cards" USING btree ("fy_start_year","sort_order");
CREATE UNIQUE INDEX "accounts_cc_months_uq" ON "accounts_cc_months" USING btree ("card_id","month");
CREATE INDEX "accounts_due_items_sort_idx" ON "accounts_due_items" USING btree ("sort_order");
CREATE INDEX "accounts_due_items_area_idx" ON "accounts_due_items" USING btree ("area");
CREATE INDEX "accounts_fno_items_fy_sort_idx" ON "accounts_fno_items" USING btree ("fy_start_year","sort_order");
CREATE UNIQUE INDEX "accounts_fno_months_uq" ON "accounts_fno_months" USING btree ("item_id","month");
CREATE INDEX "accounts_it_folders_sort_idx" ON "accounts_it_folders" USING btree ("sort_order");
CREATE UNIQUE INDEX "accounts_loan_cells_uq" ON "accounts_loan_cells" USING btree ("loan_id","period_id");
CREATE INDEX "accounts_loan_items_sort_idx" ON "accounts_loan_items" USING btree ("sort_order");
CREATE INDEX "accounts_loan_periods_sort_idx" ON "accounts_loan_periods" USING btree ("sort_order");
CREATE INDEX "accounts_lookups_kind_idx" ON "accounts_lookups" USING btree ("kind");
CREATE UNIQUE INDEX "accounts_monthly_checks_uq" ON "accounts_monthly_checks" USING btree ("item_id","fy_start_year","month");
CREATE INDEX "accounts_monthly_checks_fy_idx" ON "accounts_monthly_checks" USING btree ("fy_start_year");
CREATE INDEX "accounts_monthly_items_sort_idx" ON "accounts_monthly_items" USING btree ("sort_order");
CREATE INDEX "accounts_shares_sort_idx" ON "accounts_shares" USING btree ("sort_order");
CREATE INDEX "accounts_sip_items_fy_sort_idx" ON "accounts_sip_items" USING btree ("fy_start_year","sort_order");
CREATE UNIQUE INDEX "accounts_sip_months_uq" ON "accounts_sip_months" USING btree ("item_id","month");
CREATE INDEX "accounts_task_list_status_idx" ON "accounts_task_list" USING btree ("status");
CREATE INDEX "accounts_vasa_sort_idx" ON "accounts_vasa_balances" USING btree ("sort_order");
CREATE UNIQUE INDEX "accounts_weekly_checks_uq" ON "accounts_weekly_checks" USING btree ("item_id","period_year","period_month","week_no");
CREATE INDEX "accounts_weekly_checks_period_idx" ON "accounts_weekly_checks" USING btree ("period_year","period_month");
CREATE INDEX "accounts_weekly_items_sort_idx" ON "accounts_weekly_items" USING btree ("sort_order");
CREATE INDEX "achievements_earned_employee_idx" ON "achievements_earned" USING btree ("employee_id");
CREATE INDEX "agreements_employee_idx" ON "agreements" USING btree ("employee_id");
CREATE INDEX "agreements_status_idx" ON "agreements" USING btree ("status");
CREATE UNIQUE INDEX "agreements_sign_token_uq" ON "agreements" USING btree ("sign_token");
CREATE INDEX "ai_usage_user_idx" ON "ai_usage" USING btree ("user_id","created_at");
CREATE INDEX "ai_usage_feature_idx" ON "ai_usage" USING btree ("feature","created_at");
CREATE INDEX "amb_activities_ambassador_idx" ON "amb_activities" USING btree ("ambassador_id","occurred_at");
CREATE INDEX "amb_activities_remind_idx" ON "amb_activities" USING btree ("remind_at");
CREATE UNIQUE INDEX "amb_ambassador_products_uq" ON "amb_ambassador_products" USING btree ("ambassador_id","product_id");
CREATE INDEX "amb_ambassadors_status_idx" ON "amb_ambassadors" USING btree ("archived","status");
CREATE INDEX "amb_ambassadors_owner_idx" ON "amb_ambassadors" USING btree ("owner_id");
CREATE INDEX "amb_documents_ambassador_idx" ON "amb_documents" USING btree ("ambassador_id","name","version");
CREATE UNIQUE INDEX "amb_payout_referrals_uq" ON "amb_payout_referrals" USING btree ("payout_id","referral_id");
CREATE INDEX "amb_payouts_ambassador_idx" ON "amb_payouts" USING btree ("ambassador_id","paid_on");
CREATE INDEX "amb_products_active_idx" ON "amb_products" USING btree ("is_active","sort_order","name");
CREATE INDEX "amb_referrals_ambassador_idx" ON "amb_referrals" USING btree ("ambassador_id");
CREATE INDEX "amb_referrals_stage_idx" ON "amb_referrals" USING btree ("stage");
CREATE INDEX "amb_referrals_outcome_idx" ON "amb_referrals" USING btree ("outcome");
CREATE INDEX "amb_referrals_commission_idx" ON "amb_referrals" USING btree ("commission_status");
CREATE INDEX "amb_referrals_received_idx" ON "amb_referrals" USING btree ("received_on");
CREATE INDEX "appr_attitude_employee_idx" ON "appr_attitude" USING btree ("employee_id");
CREATE UNIQUE INDEX "appr_dimension_score_uq" ON "appr_dimension_score" USING btree ("employee_id","dimension_key");
CREATE INDEX "appr_dimension_score_employee_idx" ON "appr_dimension_score" USING btree ("employee_id");
CREATE INDEX "appr_item_score_employee_idx" ON "appr_item_score" USING btree ("employee_id");
CREATE UNIQUE INDEX "appr_item_score_item_uq" ON "appr_item_score" USING btree ("item_kind","item_id");
CREATE INDEX "appr_kpi_employee_idx" ON "appr_kpi" USING btree ("employee_id");
CREATE INDEX "appr_skill_employee_idx" ON "appr_skill" USING btree ("employee_id");
CREATE INDEX "appraisal_attachments_item_idx" ON "appraisal_attachments" USING btree ("item_id");
CREATE UNIQUE INDEX "appraisal_culture_period_para_uq" ON "appraisal_culture_assignments" USING btree ("period","para_id");
CREATE UNIQUE INDEX "appraisal_culture_period_serial_uq" ON "appraisal_culture_assignments" USING btree ("period","serial");
CREATE INDEX "appraisal_culture_period_idx" ON "appraisal_culture_assignments" USING btree ("period");
CREATE UNIQUE INDEX "appraisal_cycles_period_uq" ON "appraisal_cycles" USING btree ("period");
CREATE INDEX "appraisal_items_cycle_emp_idx" ON "appraisal_items" USING btree ("cycle_id","employee_id");
CREATE INDEX "appraisal_items_emp_dim_idx" ON "appraisal_items" USING btree ("employee_id","dimension");
CREATE INDEX "appraisal_items_status_idx" ON "appraisal_items" USING btree ("status");
CREATE UNIQUE INDEX "appraisal_scores_item_uq" ON "appraisal_scores" USING btree ("item_id");
CREATE INDEX "approval_tokens_kind_target_idx" ON "approval_tokens" USING btree ("kind","target_id");
CREATE UNIQUE INDEX "attendance_discipline_notes_uq" ON "attendance_discipline_notes" USING btree ("employee_id","month");
CREATE UNIQUE INDEX "attendance_logs_employee_day_kind_uq" ON "attendance_logs" USING btree ("employee_id","log_date","kind");
CREATE INDEX "attendance_logs_date_idx" ON "attendance_logs" USING btree ("log_date");
CREATE INDEX "attendance_logs_employee_date_idx" ON "attendance_logs" USING btree ("employee_id","log_date");
CREATE UNIQUE INDEX "attsd_emp_month_day_uidx" ON "attendance_sheet_day" USING btree ("employee_name","month","day");
CREATE INDEX "attsd_employee_date_idx" ON "attendance_sheet_day" USING btree ("employee_id","date");
CREATE INDEX "attsd_month_idx" ON "attendance_sheet_day" USING btree ("month");
CREATE UNIQUE INDEX "attsm_emp_month_uidx" ON "attendance_sheet_month" USING btree ("employee_name","month");
CREATE INDEX "attsm_month_idx" ON "attendance_sheet_month" USING btree ("month");
CREATE INDEX "attsm_employee_idx" ON "attendance_sheet_month" USING btree ("employee_id");
CREATE INDEX "audit_data_exports_employee_idx" ON "audit_data_exports" USING btree ("employee_id","requested_at");
CREATE INDEX "auth_sessions_employee_idx" ON "auth_sessions" USING btree ("employee_id","revoked_at","last_seen_at");
CREATE INDEX "auth_sessions_firebase_uid_idx" ON "auth_sessions" USING btree ("firebase_uid");
CREATE UNIQUE INDEX "broadcast_poll_response_uq" ON "broadcast_poll_responses" USING btree ("broadcast_id","employee_id");
CREATE UNIQUE INDEX "broadcast_recipient_uq" ON "broadcast_recipients" USING btree ("broadcast_id","employee_id");
CREATE INDEX "broadcast_recipient_emp_idx" ON "broadcast_recipients" USING btree ("employee_id","status");
CREATE INDEX "broadcasts_status_idx" ON "broadcasts" USING btree ("status");
CREATE INDEX "broadcasts_published_idx" ON "broadcasts" USING btree ("published_at");
CREATE INDEX "ca_handover_credentials_portal_idx" ON "ca_handover_credentials" USING btree ("portal_type");
CREATE INDEX "calendar_events_date_idx" ON "calendar_events" USING btree ("event_date");
CREATE INDEX "calendar_events_source_idx" ON "calendar_events" USING btree ("source","source_ref_id");
CREATE INDEX "calendar_events_obligation_idx" ON "calendar_events" USING btree ("obligation_id");
CREATE INDEX "candidate_intake_created_at_idx" ON "candidate_intake" USING btree ("created_at");
CREATE INDEX "candidate_intake_status_idx" ON "candidate_intake" USING btree ("status");
CREATE INDEX "clients_active_name_idx" ON "clients" USING btree ("is_active","name");
CREATE UNIQUE INDEX "command_log_dedupe_uidx" ON "command_log" USING btree ("dedupe_key");
CREATE INDEX "command_log_pending_idx" ON "command_log" USING btree ("status","next_attempt_at");
CREATE INDEX "comp_off_credits_employee_status_idx" ON "comp_off_credits" USING btree ("employee_id","status");
CREATE UNIQUE INDEX "ctc_breakups_employee_version_uq" ON "ctc_breakups" USING btree ("employee_id","version");
CREATE INDEX "ctc_breakups_employee_idx" ON "ctc_breakups" USING btree ("employee_id");
CREATE INDEX "daily_checklist_emp_date_idx" ON "daily_checklist" USING btree ("employee_id","plan_date");
CREATE INDEX "daily_checklist_date_idx" ON "daily_checklist" USING btree ("plan_date");
CREATE UNIQUE INDEX "daily_checklist_emp_date_goal_idx" ON "daily_checklist" USING btree ("employee_id","plan_date","goal_id");
CREATE INDEX "daily_checklist_cascade_goal_idx" ON "daily_checklist" USING btree ("cascade_goal_id");
CREATE UNIQUE INDEX "daily_checklist_emp_date_cascade_goal_uq" ON "daily_checklist" USING btree ("employee_id","plan_date","cascade_goal_id");
CREATE UNIQUE INDEX "dcr_employee_date_uidx" ON "daily_checklist_reviews" USING btree ("employee_id","plan_date");
CREATE INDEX "dcr_employee_date_idx" ON "daily_checklist_reviews" USING btree ("employee_id","plan_date");
CREATE UNIQUE INDEX "daily_plan_day_emp_date_uq" ON "daily_plan_day" USING btree ("employee_id","plan_date");
CREATE INDEX "dcc_clients_owner_idx" ON "dcc_clients" USING btree ("owner_employee_id","section","sort_order");
CREATE INDEX "dcc_entries_date_idx" ON "dcc_entries" USING btree ("entry_date");
CREATE INDEX "dcc_entries_subject_idx" ON "dcc_entries" USING btree ("subject_id");
CREATE UNIQUE INDEX "dcc_item_subjects_uq" ON "dcc_item_subjects" USING btree ("item_id","subject_id");
CREATE INDEX "dcc_item_subjects_item_idx" ON "dcc_item_subjects" USING btree ("item_id","sort_order");
CREATE INDEX "dcc_kpi_items_owner_idx" ON "dcc_kpi_items" USING btree ("owner_employee_id","sort_order");
CREATE INDEX "dcc_kpi_items_client_idx" ON "dcc_kpi_items" USING btree ("client_id");
CREATE UNIQUE INDEX "dcc_reviews_uq" ON "dcc_reviews" USING btree ("owner_employee_id","review_date");
CREATE INDEX "dcc_subjects_owner_idx" ON "dcc_subjects" USING btree ("owner_employee_id","sort_order");
CREATE INDEX "departments_active_sort_idx" ON "departments" USING btree ("is_active","sort_order","name");
CREATE INDEX "designations_active_name_idx" ON "designations" USING btree ("is_active","name");
CREATE UNIQUE INDEX "device_push_tokens_token_uq" ON "device_push_tokens" USING btree ("token");
CREATE INDEX "device_push_tokens_employee_idx" ON "device_push_tokens" USING btree ("employee_id");
CREATE INDEX "document_events_doc_created_idx" ON "document_events" USING btree ("document_id","created_at");
CREATE INDEX "document_events_actor_created_idx" ON "document_events" USING btree ("actor_id","created_at");
CREATE INDEX "document_events_created_idx" ON "document_events" USING btree ("created_at");
CREATE INDEX "document_instances_employee_idx" ON "document_instances" USING btree ("employee_id");
CREATE INDEX "document_instances_type_idx" ON "document_instances" USING btree ("type_key");
CREATE INDEX "document_instances_status_idx" ON "document_instances" USING btree ("status");
CREATE INDEX "document_signatures_doc_idx" ON "document_signatures" USING btree ("doc_kind","doc_id");
CREATE INDEX "document_signatures_signer_idx" ON "document_signatures" USING btree ("signer_employee_id");
CREATE INDEX "documents_created_idx" ON "documents" USING btree ("created_at");
CREATE INDEX "documents_task_idx" ON "documents" USING btree ("task_id");
CREATE INDEX "documents_goal_idx" ON "documents" USING btree ("goal_id");
CREATE INDEX "documents_weekly_goal_idx" ON "documents" USING btree ("weekly_goal_id");
CREATE INDEX "employee_departments_department_idx" ON "employee_departments" USING btree ("department_id");
CREATE INDEX "employee_departments_employee_idx" ON "employee_departments" USING btree ("employee_id");
CREATE INDEX "empdoc_employee_idx" ON "employee_documents" USING btree ("employee_id","doc_type");
CREATE INDEX "empdoc_type_idx" ON "employee_documents" USING btree ("doc_type");
CREATE INDEX "empdoc_archived_idx" ON "employee_documents" USING btree ("archived");
CREATE INDEX "employee_events_employee_created_idx" ON "employee_events" USING btree ("employee_id","created_at");
CREATE INDEX "employee_events_actor_created_idx" ON "employee_events" USING btree ("actor_id","created_at");
CREATE INDEX "employee_events_created_idx" ON "employee_events" USING btree ("created_at");
CREATE INDEX "employee_score_daily_emp_idx" ON "employee_score_daily" USING btree ("employee_id");
CREATE INDEX "employee_score_daily_day_idx" ON "employee_score_daily" USING btree ("day");
CREATE INDEX "event_batch_schedules_type_idx" ON "event_batch_schedules" USING btree ("batch_type_id");
CREATE INDEX "event_batch_schedules_range_idx" ON "event_batch_schedules" USING btree ("start_date","end_date");
CREATE UNIQUE INDEX "event_holidays_name_fy_date_uidx" ON "event_holidays" USING btree ("name","fy_start_year","holiday_date");
CREATE INDEX "event_holidays_fy_idx" ON "event_holidays" USING btree ("fy_start_year","holiday_date");
CREATE INDEX "event_log_aggregate_idx" ON "event_log" USING btree ("aggregate_type","aggregate_id","seq");
CREATE INDEX "event_log_type_idx" ON "event_log" USING btree ("event_type","seq");
CREATE INDEX "event_log_occurred_idx" ON "event_log" USING btree ("occurred_at");
CREATE UNIQUE INDEX "event_log_event_id_uidx" ON "event_log" USING btree ("event_id");
CREATE UNIQUE INDEX "goal_ai_insights_goal_uq" ON "goal_ai_insights" USING btree ("goal_id");
CREATE UNIQUE INDEX "goal_ai_insights_weekly_uq" ON "goal_ai_insights" USING btree ("weekly_goal_id");
CREATE INDEX "goal_capture_log_employee_idx" ON "goal_capture_log" USING btree ("employee_id","created_at");
CREATE INDEX "goal_comments_goal_idx" ON "goal_comments" USING btree ("goal_id","created_at");
CREATE INDEX "goal_comments_weekly_idx" ON "goal_comments" USING btree ("weekly_goal_id","created_at");
CREATE INDEX "goal_dependencies_goal_idx" ON "goal_dependencies" USING btree ("goal_id");
CREATE INDEX "goal_dependencies_weekly_idx" ON "goal_dependencies" USING btree ("weekly_goal_id");
CREATE INDEX "goal_dependencies_on_goal_idx" ON "goal_dependencies" USING btree ("on_goal_id");
CREATE INDEX "goal_links_goal_idx" ON "goal_links" USING btree ("goal_id");
CREATE INDEX "goal_links_weekly_idx" ON "goal_links" USING btree ("weekly_goal_id");
CREATE INDEX "goal_lookups_kind_idx" ON "goal_lookups" USING btree ("kind");
CREATE INDEX "goal_reviews_goal_idx" ON "goal_reviews" USING btree ("goal_id");
CREATE INDEX "goal_reviews_weekly_goal_idx" ON "goal_reviews" USING btree ("weekly_goal_id");
CREATE INDEX "goals_emp_period_key_idx" ON "goals" USING btree ("employee_id","period","period_key");
CREATE INDEX "goals_parent_idx" ON "goals" USING btree ("parent_goal_id");
CREATE INDEX "goals_period_key_idx" ON "goals" USING btree ("period_key");
CREATE INDEX "goals_cloned_from_idx" ON "goals" USING btree ("cloned_from_id");
CREATE INDEX "goals_capture_batch_id_idx" ON "goals" USING btree ("capture_batch_id");
CREATE INDEX "holidays_date_idx" ON "holidays" USING btree ("holiday_date");
CREATE UNIQUE INDEX "hr_confirmation_reminders_uq" ON "hr_confirmation_reminders" USING btree ("employee_id","kind");
CREATE INDEX "hr_ticket_attachments_ticket_idx" ON "hr_ticket_attachments" USING btree ("ticket_id");
CREATE INDEX "hr_ticket_messages_ticket_idx" ON "hr_ticket_messages" USING btree ("ticket_id","created_at");
CREATE UNIQUE INDEX "hr_tickets_ticket_no_uq" ON "hr_tickets" USING btree ("ticket_no");
CREATE INDEX "hr_tickets_employee_idx" ON "hr_tickets" USING btree ("employee_id","status");
CREATE INDEX "hr_tickets_assignee_idx" ON "hr_tickets" USING btree ("assignee_id","status");
CREATE INDEX "hr_tickets_status_idx" ON "hr_tickets" USING btree ("status","priority");
CREATE INDEX "hr_tickets_category_idx" ON "hr_tickets" USING btree ("category");
CREATE INDEX "incentive_entries_period_idx" ON "incentive_entries" USING btree ("period_month");
CREATE INDEX "incentive_entries_employee_idx" ON "incentive_entries" USING btree ("employee_id");
CREATE INDEX "incentive_participants_entry_idx" ON "incentive_participants" USING btree ("entry_id");
CREATE INDEX "incentive_participants_project_idx" ON "incentive_participants" USING btree ("project_id");
CREATE INDEX "incentive_participants_employee_idx" ON "incentive_participants" USING btree ("employee_id");
CREATE INDEX "incentive_participants_period_idx" ON "incentive_participants" USING btree ("period_month");
CREATE INDEX "incentive_payout_events_employee_idx" ON "incentive_payout_events" USING btree ("employee_id");
CREATE INDEX "incentive_payout_events_run_idx" ON "incentive_payout_events" USING btree ("salary_run_id");
CREATE INDEX "incentive_payout_events_period_idx" ON "incentive_payout_events" USING btree ("period_month");
CREATE INDEX "incentive_projects_period_idx" ON "incentive_projects" USING btree ("period_month");
CREATE INDEX "incentive_projects_supervisor_idx" ON "incentive_projects" USING btree ("supervisor_id");
CREATE INDEX "incentive_projects_intern_idx" ON "incentive_projects" USING btree ("intern_id");
CREATE INDEX "incentive_requests_employee_created_idx" ON "incentive_requests" USING btree ("employee_id","created_at");
CREATE INDEX "incentive_requests_status_created_idx" ON "incentive_requests" USING btree ("status","created_at");
CREATE UNIQUE INDEX "incentive_targets_name_period_uq" ON "incentive_targets" USING btree ("emp_name","period_month");
CREATE INDEX "index_links_section_idx" ON "index_links" USING btree ("section_id","sort_order");
CREATE INDEX "interview_positions_active_sort_idx" ON "interview_positions" USING btree ("is_active","sort_order","label");
CREATE INDEX "kpi_assignment_history_assignment_idx" ON "kpi_assignment_history" USING btree ("assignment_id");
CREATE INDEX "kpi_assignment_history_changed_on_idx" ON "kpi_assignment_history" USING btree ("changed_on");
CREATE INDEX "kpi_assignments_employee_idx" ON "kpi_assignments" USING btree ("employee_id");
CREATE INDEX "kpi_assignments_employee_quarter_idx" ON "kpi_assignments" USING btree ("employee_id","effective_quarter");
CREATE INDEX "leave_requests_employee_start_idx" ON "leave_requests" USING btree ("employee_id","start_date");
CREATE INDEX "leave_requests_status_idx" ON "leave_requests" USING btree ("status");
CREATE UNIQUE INDEX "letter_templates_type_key_uq" ON "letter_templates" USING btree ("type_key");
CREATE UNIQUE INDEX "mobile_devices_device_id_uq" ON "mobile_devices" USING btree ("device_id");
CREATE INDEX "mobile_devices_employee_idx" ON "mobile_devices" USING btree ("employee_id");
CREATE INDEX "module_submissions_module_created_idx" ON "module_submissions" USING btree ("module","created_at");
CREATE INDEX "module_submissions_employee_idx" ON "module_submissions" USING btree ("employee_id");
CREATE INDEX "notification_dispatch_log_retry_idx" ON "notification_dispatch_log" USING btree ("next_attempt_at","attempt_count") WHERE status = 'failed';
CREATE INDEX "notification_dispatch_log_notification_idx" ON "notification_dispatch_log" USING btree ("notification_id","channel","attempted_at");
CREATE INDEX "notification_preferences_employee_idx" ON "notification_preferences" USING btree ("employee_id");
CREATE INDEX "notifications_user_unread_created_idx" ON "notifications" USING btree ("user_id","read_at","created_at");
CREATE INDEX "notifications_user_kind_created_idx" ON "notifications" USING btree ("user_id","kind","created_at");
CREATE INDEX "notifications_created_idx" ON "notifications" USING btree ("created_at");
CREATE UNIQUE INDEX "obligation_completions_uidx" ON "obligation_completions" USING btree ("obligation_id","fy_start_year","period_month");
CREATE UNIQUE INDEX "onb_employee_uidx" ON "onboarding_submissions" USING btree ("employee_id");
CREATE INDEX "outstanding_attachments_owner_idx" ON "outstanding_attachments" USING btree ("owner_type","owner_id");
CREATE INDEX "outstanding_collections_client_idx" ON "outstanding_collections" USING btree ("client_name");
CREATE INDEX "outstanding_collections_date_idx" ON "outstanding_collections" USING btree ("collected_at");
CREATE INDEX "outstanding_contracts_client_idx" ON "outstanding_contracts" USING btree ("client_name");
CREATE INDEX "outstanding_contracts_status_idx" ON "outstanding_contracts" USING btree ("status");
CREATE INDEX "outstanding_entities_active_name_idx" ON "outstanding_entities" USING btree ("is_active","name");
CREATE INDEX "outstanding_entries_status_due_idx" ON "outstanding_entries" USING btree ("status","due_date");
CREATE INDEX "outstanding_entries_client_idx" ON "outstanding_entries" USING btree ("client");
CREATE INDEX "outstanding_followups_entry_created_idx" ON "outstanding_followups" USING btree ("entry_id","created_at");
CREATE INDEX "outstanding_installments_due_idx" ON "outstanding_installments" USING btree ("due_date");
CREATE INDEX "outstanding_installments_contract_idx" ON "outstanding_installments" USING btree ("contract_id","period_index");
CREATE INDEX "outstanding_payment_modes_active_name_idx" ON "outstanding_payment_modes" USING btree ("is_active","name");
CREATE INDEX "outstanding_products_active_name_idx" ON "outstanding_products" USING btree ("is_active","name");
CREATE INDEX "outstanding_responsibles_active_name_idx" ON "outstanding_responsibles" USING btree ("is_active","name");
CREATE INDEX "overtime_entries_employee_date_idx" ON "overtime_entries" USING btree ("employee_id","work_date");
CREATE INDEX "overtime_entries_status_idx" ON "overtime_entries" USING btree ("status");
CREATE UNIQUE INDEX "plc_emp_period_uidx" ON "paid_leave_cycle" USING btree ("employee_name","period");
CREATE INDEX "plc_employee_idx" ON "paid_leave_cycle" USING btree ("employee_id");
CREATE INDEX "paying_entities_active_name_idx" ON "paying_entities" USING btree ("is_active","name");
CREATE UNIQUE INDEX "perf_scorecard_person_month_uk" ON "performance_scorecards" USING btree ("person_key","period_month");
CREATE INDEX "pg_business_categories_active_idx" ON "pg_business_categories" USING btree ("is_active","sort_order","name");
CREATE INDEX "pg_designations_active_idx" ON "pg_designations" USING btree ("is_active","sort_order","name");
CREATE INDEX "pg_introductions_created_idx" ON "pg_introductions" USING btree ("created_at");
CREATE INDEX "pg_introductions_company_idx" ON "pg_introductions" USING btree ("prospect_company");
CREATE INDEX "pg_introductions_reminder_idx" ON "pg_introductions" USING btree ("next_reminder_date");
CREATE INDEX "pg_reference_sources_active_idx" ON "pg_reference_sources" USING btree ("is_active","sort_order","name");
CREATE INDEX "pg_sales_people_active_idx" ON "pg_sales_people" USING btree ("is_active","sort_order","name");
CREATE INDEX "pinned_items_employee_idx" ON "pinned_items" USING btree ("employee_id","sort_order");
CREATE UNIQUE INDEX "pms_monthly_review_subj_rev_rel_period_uq" ON "pms_monthly_review" USING btree ("subject_id","reviewer_id","relation","period");
CREATE INDEX "pms_monthly_review_subject_idx" ON "pms_monthly_review" USING btree ("subject_id","period");
CREATE INDEX "pms_monthly_review_reviewer_idx" ON "pms_monthly_review" USING btree ("reviewer_id");
CREATE INDEX "pms_personal_goal_emp_idx" ON "pms_personal_goal" USING btree ("employee_id","period");
CREATE UNIQUE INDEX "pms_promotion_signal_employee_status_uidx" ON "pms_promotion_signal" USING btree ("employee_id","status");
CREATE INDEX "pms_promotion_signal_employee_idx" ON "pms_promotion_signal" USING btree ("employee_id");
CREATE INDEX "pms_recognition_employee_idx" ON "pms_recognition" USING btree ("employee_id");
CREATE INDEX "pms_recognition_period_idx" ON "pms_recognition" USING btree ("period");
CREATE UNIQUE INDEX "pms_review_employee_period_uidx" ON "pms_review" USING btree ("employee_id","period");
CREATE INDEX "pms_review_employee_idx" ON "pms_review" USING btree ("employee_id");
CREATE UNIQUE INDEX "policy_compliance_key_emp_uk" ON "policy_compliance" USING btree ("policy_key","employee_id");
CREATE UNIQUE INDEX "policy_versions_key_version_uk" ON "policy_versions" USING btree ("policy_key","version");
CREATE UNIQUE INDEX "product_options_label_idx" ON "product_options" USING btree ("label");
CREATE INDEX "project_nodes_parent_idx" ON "project_nodes" USING btree ("parent_id");
CREATE INDEX "project_nodes_kind_idx" ON "project_nodes" USING btree ("kind","is_archived");
CREATE INDEX "push_subscriptions_user_idx" ON "push_subscriptions" USING btree ("user_id");
CREATE INDEX "rev_agent_audit_run_idx" ON "rev_agent_audit" USING btree ("run_id","created_at");
CREATE INDEX "rev_agent_runs_slug_idx" ON "rev_agent_runs" USING btree ("agent_slug","started_at");
CREATE INDEX "rev_agent_runs_user_idx" ON "rev_agent_runs" USING btree ("user_id","started_at");
CREATE INDEX "rev_campaigns_status_idx" ON "rev_campaigns" USING btree ("status","scheduled_at");
CREATE INDEX "rev_drafts_status_idx" ON "rev_drafts" USING btree ("status","created_at");
CREATE INDEX "rev_drafts_lead_idx" ON "rev_drafts" USING btree ("lead_id");
CREATE INDEX "rev_lead_events_lead_idx" ON "rev_lead_events" USING btree ("lead_id","created_at");
CREATE INDEX "rev_leads_status_idx" ON "rev_leads" USING btree ("status");
CREATE INDEX "rev_leads_owner_idx" ON "rev_leads" USING btree ("owner_id");
CREATE INDEX "rev_leads_review_idx" ON "rev_leads" USING btree ("in_review");
CREATE INDEX "rev_leads_email_idx" ON "rev_leads" USING btree ("contact_email");
CREATE INDEX "rev_leads_created_idx" ON "rev_leads" USING btree ("created_at");
CREATE INDEX "rev_suppression_email_idx" ON "rev_suppression" USING btree ("contact_email");
CREATE INDEX "rev_suppression_phone_idx" ON "rev_suppression" USING btree ("contact_phone");
CREATE INDEX "salary_advances_emp_month_idx" ON "salary_advances" USING btree ("employee_id","month");
CREATE UNIQUE INDEX "salary_breakup_emp_month_uidx" ON "salary_breakup" USING btree ("employee_name","month");
CREATE INDEX "salary_breakup_month_idx" ON "salary_breakup" USING btree ("month");
CREATE INDEX "salary_breakup_emp_idx" ON "salary_breakup" USING btree ("employee_id");
CREATE INDEX "salary_payments_run_idx" ON "salary_payments" USING btree ("salary_run_id");
CREATE INDEX "salary_payments_employee_idx" ON "salary_payments" USING btree ("employee_id");
CREATE INDEX "salary_payments_month_idx" ON "salary_payments" USING btree ("month");
CREATE UNIQUE INDEX "salary_policy_consents_emp_version_uq" ON "salary_policy_consents" USING btree ("employee_id","policy_version");
CREATE UNIQUE INDEX "salary_runs_emp_month_uq" ON "salary_runs" USING btree ("employee_id","month");
CREATE INDEX "salary_runs_month_idx" ON "salary_runs" USING btree ("month");
CREATE INDEX "salary_runs_import_batch_idx" ON "salary_runs" USING btree ("import_batch_id");
CREATE INDEX "settings_events_scope_target_created_idx" ON "settings_events" USING btree ("scope","target_id","created_at");
CREATE INDEX "settings_events_actor_created_idx" ON "settings_events" USING btree ("actor_id","created_at");
CREATE INDEX "settings_events_created_idx" ON "settings_events" USING btree ("created_at");
CREATE INDEX "skill_lookups_kind_idx" ON "skill_lookups" USING btree ("kind");
CREATE INDEX "subjects_active_name_idx" ON "subjects" USING btree ("is_active","name");
CREATE INDEX "sync_runs_job_started_idx" ON "sync_runs" USING btree ("job","started_at");
CREATE INDEX "task_attachments_task_idx" ON "task_attachments" USING btree ("task_id","created_at");
CREATE INDEX "task_checklist_task_idx" ON "task_checklist_items" USING btree ("task_id","sort_order");
CREATE INDEX "task_events_task_created_idx" ON "task_events" USING btree ("task_id","created_at");
CREATE INDEX "task_events_actor_created_idx" ON "task_events" USING btree ("actor_id","created_at");
CREATE INDEX "task_events_created_idx" ON "task_events" USING btree ("created_at");
CREATE INDEX "task_metrics_daily_day_idx" ON "task_metrics_daily" USING btree ("day");
CREATE INDEX "task_time_events_task_at_idx" ON "task_time_events" USING btree ("task_id","at");
CREATE INDEX "task_time_events_doer_at_idx" ON "task_time_events" USING btree ("doer_id","at");
CREATE INDEX "task_time_events_kind_idx" ON "task_time_events" USING btree ("kind");
CREATE INDEX "task_time_events_session_idx" ON "task_time_events" USING btree ("session_id");
CREATE INDEX "task_work_sessions_task_started_idx" ON "task_work_sessions" USING btree ("task_id","started_at");
CREATE INDEX "task_work_sessions_doer_started_idx" ON "task_work_sessions" USING btree ("doer_id","started_at");
CREATE INDEX "task_work_sessions_live_idx" ON "task_work_sessions" USING btree ("doer_id") WHERE "task_work_sessions"."ended_at" is null;
CREATE INDEX "task_work_snapshots_session_idx" ON "task_work_snapshots" USING btree ("session_id","captured_at");
CREATE INDEX "task_work_snapshots_doer_idx" ON "task_work_snapshots" USING btree ("doer_id","captured_at");
CREATE INDEX "tasks_doer_created_idx" ON "tasks" USING btree ("doer_id","created_at");
CREATE INDEX "tasks_origin_goal_idx" ON "tasks" USING btree ("origin_goal_id");
CREATE INDEX "tasks_initiator_created_idx" ON "tasks" USING btree ("initiator_id","created_at");
CREATE INDEX "tasks_status_created_idx" ON "tasks" USING btree ("status","created_at");
CREATE INDEX "tasks_pending_created_idx" ON "tasks" USING btree ("created_at") WHERE "tasks"."status" IN ('not_started','initiated','follow_up','need_help','need_info','follow_up_1','follow_up_2','follow_up_3');
CREATE INDEX "tasks_archived_idx" ON "tasks" USING btree ("archived","created_at");
CREATE INDEX "tasks_created_by_idx" ON "tasks" USING btree ("created_by_id");
CREATE INDEX "tasks_approval_status_idx" ON "tasks" USING btree ("approval_status");
CREATE INDEX "tasks_due_at_idx" ON "tasks" USING btree ("due_at");
CREATE INDEX "tasks_approved_by_idx" ON "tasks" USING btree ("approved_by_id");
CREATE INDEX "tasks_transferred_from_idx" ON "tasks" USING btree ("transferred_from_id");
CREATE INDEX "tasks_project_node_idx" ON "tasks" USING btree ("project_node_id");
CREATE INDEX "tasks_search_trgm_idx" ON "tasks" USING gin ("search_text" gin_trgm_ops);
CREATE INDEX "tc_assessments_emp_idx" ON "tc_assessments" USING btree ("employee_id");
CREATE INDEX "tc_assessments_session_idx" ON "tc_assessments" USING btree ("session_id");
CREATE INDEX "tc_attempts_emp_test_idx" ON "tc_attempts" USING btree ("employee_id","test_id","taken_at");
CREATE INDEX "tc_feedback_status_idx" ON "tc_feedback" USING btree ("status");
CREATE INDEX "tc_feedback_created_idx" ON "tc_feedback" USING btree ("created_at");
CREATE INDEX "tc_feedback_service_idx" ON "tc_feedback" USING btree ("service_id");
CREATE INDEX "tc_materials_subject_idx" ON "tc_materials" USING btree ("subject_id");
CREATE INDEX "tc_materials_induction_idx" ON "tc_materials" USING btree ("part_of_induction");
CREATE INDEX "tc_materials_archived_idx" ON "tc_materials" USING btree ("archived");
CREATE INDEX "tc_materials_created_idx" ON "tc_materials" USING btree ("created_at");
CREATE INDEX "tc_questions_test_idx" ON "tc_questions" USING btree ("test_id","position");
CREATE INDEX "tc_self_learning_emp_idx" ON "tc_self_learning" USING btree ("employee_id","learn_date");
CREATE INDEX "tc_services_active_idx" ON "tc_services" USING btree ("is_active","sort_order","name");
CREATE UNIQUE INDEX "tc_session_attendees_session_emp_uq" ON "tc_session_attendees" USING btree ("session_id","employee_id");
CREATE INDEX "tc_session_attendees_emp_idx" ON "tc_session_attendees" USING btree ("employee_id");
CREATE INDEX "tc_session_attendees_session_idx" ON "tc_session_attendees" USING btree ("session_id");
CREATE UNIQUE INDEX "tc_session_feedback_session_emp_uq" ON "tc_session_feedback" USING btree ("session_id","employee_id");
CREATE INDEX "tc_sessions_scheduled_idx" ON "tc_sessions" USING btree ("scheduled_at");
CREATE INDEX "tc_sessions_trainer_idx" ON "tc_sessions" USING btree ("trainer_id");
CREATE INDEX "tc_sessions_status_idx" ON "tc_sessions" USING btree ("status");
CREATE UNIQUE INDEX "tc_share_feedback_share_rater_uq" ON "tc_share_feedback" USING btree ("share_id","rater_id");
CREATE UNIQUE INDEX "tc_shares_emp_week_uq" ON "tc_shares" USING btree ("employee_id","week_start");
CREATE INDEX "tc_subjects_active_idx" ON "tc_subjects" USING btree ("is_active","sort_order","name");
CREATE UNIQUE INDEX "tc_tests_material_kind_uq" ON "tc_tests" USING btree ("material_id","kind");
CREATE UNIQUE INDEX "tc_watch_material_emp_uq" ON "tc_watch_progress" USING btree ("material_id","employee_id");
CREATE INDEX "webauthn_credentials_employee_idx" ON "webauthn_credentials" USING btree ("employee_id");
CREATE UNIQUE INDEX "weekly_goal_actuals_uq" ON "weekly_goal_actuals" USING btree ("goal_id","entry_date");
CREATE INDEX "weekly_goal_actuals_emp_date_idx" ON "weekly_goal_actuals" USING btree ("employee_id","entry_date");
CREATE INDEX "weekly_goals_employee_week_idx" ON "weekly_goals" USING btree ("employee_id","week_start");
CREATE INDEX "weekly_goals_week_idx" ON "weekly_goals" USING btree ("week_start");
CREATE INDEX "weekly_goals_carried_from_idx" ON "weekly_goals" USING btree ("carried_from_id");
CREATE INDEX "weekly_goals_task_id_idx" ON "weekly_goals" USING btree ("task_id");
CREATE INDEX "weekly_goals_month_goal_idx" ON "weekly_goals" USING btree ("month_goal_id");
CREATE UNIQUE INDEX "whatsapp_media_log_context_ref_uq" ON "whatsapp_media_log" USING btree ("context","ref_key");
CREATE INDEX "wss_session_idx" ON "work_session_shots" USING btree ("session_id");
CREATE INDEX "ws_emp_started_idx" ON "work_sessions" USING btree ("employee_id","started_at");
CREATE INDEX "ws_status_idx" ON "work_sessions" USING btree ("status");
