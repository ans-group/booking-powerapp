![ANS](./images/ans_logo_small.png)

# PowerApp Booking application

For more information on the PowerApps Booking Application visit <https://www.ans.co.uk>

This application is designed as a tool to help manage workspace capacity, cleaning and tracing potential contact between staff, it is provided for free as is and we recommend you test its functionality and ensure it meets your needs, before deploying into a production environment. The application is deployed as a PowerApp solution file and requires an Azure SQL Database to store the data.

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

5. On the Create SQL Database form complete the required information

    * Subscription: (Choose an available subscription to use)

    * Resource group: (Create or choose an existing resource group)

    * Database Name: (Use a name that's meaningful name, we use pp-booking-app-sql-db)

    * Server: (Either use an existing or create a new server)

    * Want to use SQL elastic pool? (No)

    * Compute + Storage: (You can start with a Basic 2GB Storage for testing purposes))

6. Click on **Review + create**

7. Click on **Create**, and wait a few minutes for the resources to be created.

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

1. Download the Booking PowerApps solution zip file here: https://github.com/ans-group/booking-powerapp/raw/master/ansbookingapp_1_0_0_9.zip

2. Open https://make.powerapps.com

3. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

4. On the left-hand menu click on **Solutions**, then from the top menu click on **Import**, a new window will open.

5. Click on **Choose File** and select the file you downloaded in step 1, then click **Next** button.

6. Click **Next** button again, then click **Import** button and wait for solution customisations to import.

7. If you receive a warning that relates to the below two items, it can safely be ignored.

   - PowerApp -> Get Available Spots
   - Recurrence -> Update Spots Not Sanitised
   - PowerApp -> Reserve Spot
   - Recurrence -> Check Spot Is Sanitised
   - PowerApp -> Update Space Capacity

8. Click on the **Close** button, to complete, **ans-booking-app** should now appear in the list of solutions.


### Record the Booking App ID

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **ans-booking-app** solution.

4. From the list of items, find **Booking App** then click on the **...** to the right of it.

5. From the menu click on **Details**

6. Find the **App ID** and record it, for later.





### Create Required PowerApp Connections

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **Data** on the left hand menu, then click on **+ New connection** at the top of the page.

4. Find **SQL Server** from the list and click on the **+** icon.

5. Complete the SQL Database information, as below.

    * Authentication Type: *SQL Server Authentication*
    * SQL Server name: *Your SQL Server*.database.windows.net
    * SQL Database name: *The SQL Database name you created earlier*
    * SQL Username: *The SQL Username for the database server*
    * Password: *The password for the SQL Username above*
    * Choose Gateway: *LEAVE EMPTY*

6. Click **Create**

7. Click on **+ New connection** at the top of the page.

8. Find **Office 365 Outlook** from the list and click on the **+** icon, then **Create**.

9. In the popup window sign-in to outlook.

10. Click on **+ New connection** at the top of the page.

11. Find **Power Apps Notification (preview)** from the list and click on the **+** icon, 

12. Enter the PowerApps Booking App ID you recorded earlier, then click **Create**.

### Update Power Automate Flow connections

To update the Power Automate Flow connections.

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **ans-booking-app** solution, then find **PowerApp -> Get Available Spots** in the list of solution components and click on it. This will open a Power Automate window.

4. On the top menu click on **Edit**, the second component in the Flow **Connections**, will be displaying a warning triangle, click on it to open.

5. Under **Select and existing connection or create new one:** click on the SQL Server connection created earlier.

6. Wait for the page to update, then click **Save**

7. Return to the PowerApps solution page and select the **PowerApp -> Reserve Spot** workflow.

8. The second component in the Flow **Connections**, will be displaying a warning triangle, click on it to open.

9. Under **Select and existing connection or create new one:** click on the SQL Server connection created earlier, then click **Save**

10. Return to the PowerApps solution page and select the **PowerApp -> Update Space Capacity** workflow.

11. The second component in the Flow **Connections**, will be displaying a warning triangle, click on it to open.

12. Under **Select and existing connection or create new one:** click on the SQL Server connection created earlier, then click **Save**

13. Return to the PowerApps solution page and select the **Recurrence -> Update Spots Not Sanitised** workflow.

14. The second component in the Flow **Connections**, will be displaying a warning triangle, click on it to open.

15. Under **Select and existing connection or create new one:** click on the SQL Server connection created earlier, then click **Save**

16. Return to the PowerApps solution page and select the **PowerApp -> Check Spot is Sanitised** workflow.

17. The second component in the Flow **Connections**, will be displaying a warning triangle, click on it to open.

18. Under **Select and existing connection or create new one:** click on the SQL Server connection created earlier.

19. Now click on the **Apply to each** component to expand it.

20. Now click on the **Condition** component within the **Apply to each** component to expand it.

21. Under both the **If yes** and **If no** conditions you will see a **Connections** displaying a warning triangle.

22. Click on one of the **Connections** components.

23. Under **Select and existing connection or create new one:** click on **Power Apps Notifications**.

24. Now click on the other **Connections** displaying a warning triangle.

25. Under **Select and existing connection or create new one:** click on **Power Apps Notifications**, then scroll down and click **Save**

### Enable the Power Automate Flows

To update the Power Automate Flow connections.

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **ans-booking-app** solution.

4. Five items with the Type Flow should appear in the list.

5. Click on the **...** to the right of Flows name, and click on **Turn on**. 

6. Repeat step 5 for the remaining in Flow items.

7. Click on **Publish all customizations** on the top menu.

### Connections within the PowerApps

To update the connection within the PowerApps Booking App or PowerApps Booking Manager App.

1. Open https://make.powerapps.com

2. From the top menu select the environment that the solution will be deployed into, this is the one we created earlier.

3. Click on the **ans-booking-app** solution.

4. Find **Booking App** in the list and click on the **...** to the right of its name.

5. From the menu click on **Edit**

6. If you receive an SQL Server connection prompt, click on **Don't Allow**

7. You should now see a blank screen called TEMP, make sure TEMP is highlighted on the left hand menu.

8. Click on **Action** from the top menu, then **Power Automate**.

9. A list of Flows will appear, click on the first one in the list.

10. A message will appear in yellow, ignore this and click on the next flow in the list.

11. A message will appear in yellow again, ignore this and click on the next flow in the list.

12. Now click on the **Data Sources** icon on the left hand menu, it should be the third icon up.

13. The Flows you just added should now be visible.

14. Below the flows click on **Connectors**, then **Office 365 Outlook**, a popup will appear, click on the Blue Icon next to Office 365 Outlook, to add the connector.

15. Under **Connectors** again, click on **Power Apps Notification**, a popup will appear, click on the Purple Icon next to Power Apps Notification, to add the connector.

16. Under **Connectors** again, scroll down and click on **See all connectors**, find **SQL Server** and click on it, a popup will appear, click on the Red Icon next to Power Apps Notification.

17. A **Choose a table** menu will appear, tick every table that starts with **ans_booking**, there should be eight selected.

18. Click on the **Connect** button, a popup will appear the data source '[dbo].[ans_bookings_user]' has the same name, click **Yes**

19. The connections are now made, next click on the **Tree View** icon is should be the second icon down on the left menu.

20. Click on **TEMP** screen, click on the **...** to the right of it and click on **Delete**.

21. Now go to **File** then click **Save**

22. After the save, click on **Publish**

23. After the publish, click on **Share** and select the users or groups you wish to grant access to the Booking App, then click **Share**