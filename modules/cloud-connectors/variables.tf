variable "resource_group" {
    type = object({
        name = string
        location = string
    })
    description = "Resource group for cloud connectors"
}