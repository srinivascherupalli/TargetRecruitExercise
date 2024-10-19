# Target Recruit Exercise

Assume the requirement to display selected fields of a child object records in the Lighting Card format on a parent record page using LWC component based on provided relationship name 
Assuming there are 2 lookup fields for the same parent object. For ex: Contact object is having 2 lookup fields related to Account object (AccountId, previous_account__c)

Input for the LWC component: 
Parent object recordId, child object API Name, child object to parent object relationship API name, fields to display on the component

This LWC component is generic and accept any object name and fields to display as long as there is relationship between to the parent object of the record page it was added. 
So for ex: Let us assume Account and Contact are the related objects, where Account object is the parent of Contact object, so now to display the contact object specified fields on the Account record page inside the Lighting card use this git repo.

To display all contacts where the contact AccountId as given Parent Object RecordId 

Steps: 

1. Login to Salesforce -> Open Account Record page on Lighting view ->Click on Edit Page ->
2. Select the LWC component "Card" from left side component section -> drag and drop the component in the are you want to display it 
3. Click the component to configure the required values like "Object Name":"Contact", "Related Field API Name":"AccountId", "Fields To display":"FirstName, LastName, Email"
4. Save the changes and reload the page

To display all contacts where the contact AccountId as given Parent Object RecordId 

Steps:

1. Login to Salesforce -> Open Account Record page on Lighting view ->Click on Edit Page ->
2. Select the LWC component "Card" from left side component section -> drag and drop the component in the are you want to display it 
3. Click the component to configure the required values like "Object Name":"Contact", "Related Field API Name":"previous_account__c", "Fields To display":"FirstName, LastName, LastModifiedDate"
4. Save the changes and reload the page
   
