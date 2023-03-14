# Databricks notebook source
dbutils.widgets.text("applicationId", "398f7d61-c9d7-490f-ab58-f5d29855ff70")
dbutils.widgets.text("azureDirectoryId", "8ca8a39f-e070-4c01-8323-3d86f11af103")
dbutils.widgets.text("storageAccountName", "demolakedeviwmt54eoa5ois")

# COMMAND ----------

applicationId = dbutils.widgets.get("applicationId")           # Application Id from Azure AD for app registration 
azureDirectoryId = dbutils.widgets.get("azureDirectoryId")     # Directory Id for the tenant
storageAccountName = dbutils.widgets.get("storageAccountName") # Name of the storage account

# COMMAND ----------

containers = ["raw", "standardized", "presentation"]

configs = {"fs.azure.account.auth.type": "OAuth",
            "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
            "fs.azure.account.oauth2.client.id": applicationId, 
            "fs.azure.account.oauth2.client.secret": dbutils.secrets.get(scope="default", key="lake"),
            "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{azureDirectoryId}/oauth2/token"}

existingMounts = dbutils.fs.mounts()

for container in containers:
    containerName = container
    mountName = container
    
    if (any(mount.mountPoint == f"/mnt/{containerName}" for mount in existingMounts)):
        print (f"Mount {container} already exists and will not be added again")
        continue
              
    dbutils.fs.mount(
        source = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/",
        mount_point = f"/mnt/{mountName}",
        extra_configs = configs)
    print (f"Mount {mountName} has been added")
