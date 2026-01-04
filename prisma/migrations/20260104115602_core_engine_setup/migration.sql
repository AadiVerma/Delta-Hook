-- CreateTable
CREATE TABLE "ExternalCredential" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "encryptedData" TEXT NOT NULL,
    "iv" TEXT NOT NULL,
    "type" TEXT NOT NULL,

    CONSTRAINT "ExternalCredential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PollJob" (
    "id" TEXT NOT NULL,
    "credentialId" TEXT,
    "sourceUrl" TEXT NOT NULL,
    "jsonPath" TEXT NOT NULL,
    "currentState" JSONB,
    "pollingInterval" INTEGER NOT NULL DEFAULT 60,
    "webhookUrl" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',

    CONSTRAINT "PollJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WebhookLog" (
    "id" TEXT NOT NULL,
    "jobId" TEXT NOT NULL,
    "firedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "responseCode" INTEGER NOT NULL,
    "payload" JSONB NOT NULL,

    CONSTRAINT "WebhookLog_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PollJob" ADD CONSTRAINT "PollJob_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "ExternalCredential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WebhookLog" ADD CONSTRAINT "WebhookLog_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "PollJob"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
