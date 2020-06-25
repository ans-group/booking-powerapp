![ANS](./images/ans_logo_small.png)

# PowerApp Booking application

For more information on the PowerApps Booking Application visit <https://www.ans.co.uk>

The application is deployed as a PowerApp solution file and requires an Azure SQL Database to store the data. 

## Pre-Requisites

The solution requires you have the following resources and permissions, during the installation.

• A Microsoft Azure Subscription and permissions to the subscription as Contributor or Owner.
• A Microsoft PowerApps Environment with available licenses.
• PowerApps User/App licensing.

## Azure SQL Database

To create an Azure SQL Database,

1. logon to the Azure Portal with an account that has **Contributor** or **Owner** permissions: https://portal.azure.com

2. Open the hamburger menu icon on the top left of the portal and click on **+ Create a resource**

3. In the search box type **SQL Database**, and click on it in the list of options.

4. Click on the **Create button**.

5. On the Create SQL Databse form complete the required information

    * Subscription: (Choose an available subscription to use)

    * Resource group: (Create or choose an existing resource group)

    * Databse Name: (Use a name thats meaningful name, we use pp-booking-app-sql-db)

    * Server: (Either use an existing or create a new server)

    * Want to use SQL elastic pool? (No)

    * Compute + Storage: (You can start with a Basic 2GB Storage for testing purposes))

6. Click on **Review + create**

7. Click on **Create**, and wait a few minuets for the resources to be created.

8. Open the hamburger menu icon on the top left of the portal and click on **SQL Databases**.

9. From the list of Databases click on the name of the one you have just created.

10. From the menu on the left click on **Query editor (preview)** 

11. Enter the logon details for the SQL server, and click **OK** button.

12. Copy the contents of the powerapp-ans-booking-app.sql file provided, into the query window and click on **> Run**.

### Create a PowerApps Environment

The application is deployed into a PowerApps Environment, you can use an existing environment or to create a new PowerApps Environment follow the steps below.

1. Login to https://admin.powerplatform.microsoft.com/environments

2. Click on the **+ New** button and create new Environment. Use a name that makes it easy to identify the environments purpose and include Prod or Dev to identify if it is production or development.

   - **Name:** **_Booking App - Prod_**
   - **Type:** Production
   - **Region:** United Kingdom
   - **Create a database:** Yes

   - **Language:** English
   - **Currency:** GBP (£)

### Deploy PowerApps Solution

The PowerApp solution

1. Download the Booking PowerApps solution zip file here: https://github.com/ans-group/booking-powerapp/raw/master/ansbookingapp_1_0_0_2.zip

2. Open https://make.powerapps.com

3. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

4. On the left-hand menu click on **Solutions**, then from the top menu click on **Import**, a new window will open.

5. Click on **Choose File** and select the file you downloaded in step 1, then click **Next** button.

6. Click **Next** button again, then click **Import** button and wait for solution customisations to import.

7. If you receive a warning that relates to the below two items, it can safely be ignored.

   - Inbound Bot Webhook
   - Send email on new request

8. Click on the **Close** button, to complete, and **ans-booking-app** should now appear in the list of solutions.

### Update Power Automate Flow connections

To update the Power Automate Flow connections.

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **ans-booking-app** solution, then find **PowerApp -> Get Available Spots** in the list of solution components and click on it. This will open a Power Automate window.

4. On the top menu click on **Edit**, each component in the Flow will be displaying a warning triangle click on the top component, to open it.

5. Click on **+Add new connection** link, it should automatically sign you in and create a new connection.

6. Click on the second component to open it, then click on **Common Data Service link** to re-use the same connection created on the first component.

7. Click on the third component to open it, then click on **Common Data Service link** to re-use the same connection created on the first component.