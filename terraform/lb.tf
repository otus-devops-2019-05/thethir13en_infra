resource "google_compute_forwarding_rule" "default" {
  project               = "${var.project}"
  name                  = "reddit-lb"
  target                = "${google_compute_target_pool.default.self_link}"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "9292"
}

resource "google_compute_target_pool" "default" {
  project          = "${var.project}"
  name             = "reddit-pool"
  region           = "${var.region}"
  session_affinity = "NONE"

  instances = [
    "europe-west1-b/reddit-app"
  ]

  health_checks = [
    "${google_compute_http_health_check.default.name}",
  ]
}

resource "google_compute_http_health_check" "default" {
  project      = "${var.project}"
  name         = "reddit-app-hc"
  request_path = "/"
  port         = "9292"
}
