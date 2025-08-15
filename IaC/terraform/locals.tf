locals {
  envs = { for tuple in regexall("(.*)=(.*)", file("../.env")) : tuple[0] => trim(tuple[1], "\"") }
}