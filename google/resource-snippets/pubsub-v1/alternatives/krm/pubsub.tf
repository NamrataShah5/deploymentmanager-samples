provider "google" {
  project = "project_id"
  region  = "region"
  zone    = "zone"
}

resource "google_pubsub_topic" "sample_topic" {
  name = "terraform-pubsub-topic"
}

resource "google_pubsub_topic" "sample_dead_letter" {
  name="terraform-pubsub-deadletter-topic"
}

resource "google_pubsub_subscription" "sample_subscription" {
  name = "terraform-pubsub-subscription"
  topic = google_pubsub_topic.sample_topic.name

  message_retention_duration="1200s"
  retain_acked_messages=true
  ack_deadline_seconds = 60

  dead_letter_policy {
    dead_letter_topic = google_pubsub_topic.sample_dead_letter.id
    max_delivery_attempts=5

  }


}
