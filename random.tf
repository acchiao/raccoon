resource "random_id" "cluster" {
  byte_length = 4
}

resource "random_id" "pool" {
  byte_length = 4
}

resource "random_id" "registry" {
  byte_length = 4
}

resource "random_id" "vpc" {
  byte_length = 4
}
