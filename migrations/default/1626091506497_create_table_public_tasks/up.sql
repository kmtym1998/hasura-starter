CREATE TABLE "public"."tasks" ("id" serial NOT NULL, "text" text NOT NULL, "user_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."tasks" IS E'タスク';