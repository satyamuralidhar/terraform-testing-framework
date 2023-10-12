// provider "azurerm" {
//   features {}
// }

// variables {
//     //keyvault
//     key_permissions = ["Get","Delete","Decrypt","Import","List","Recover","Restore","Update","Verify"]
//     secret_permissions = ["Backup","Delete","Get", "List","Purge","Recover","Restore","Set"]
//     storage_permissions = ["Backup","Delete","Get", "List", "Purge", "Recover","Restore", "Set","Update"]
//     certificate_permissions = ["Backup","Create","Delete","Get","Import", "List", "Purge", "Recover", "Restore","Update"]
//     ssh_secret_name = "appkey"
//     kv_sku_name = "standard"
// }

// #variable validation
// run application_validation {
//     command = plan
//     variables {
//         key_permissions = ["Gets"]
//         secret_permissions = ["Backups"]
//         storage_permissions = ["Backups"]
//         certificate_permissions = ["Backups"]
//         ssh_secret_name = "appkeydemo"
//         kv_sku_name = "standardL"
//     }
// }