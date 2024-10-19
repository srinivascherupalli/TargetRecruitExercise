public with sharing class SObjectRelatedRecords {

    //Method to retrieve child records by given details
    //Input : Parent RecordId, Child Object Api Name, Child Object Field Name, fields to display on screen (comma separated input) 
    //Output : Map of list of records converted to string and status of success or error
    @AuraEnabled
    public static Map<String, String> getRelatedRecordsByParentId(Id parentRecordId, String childObjectApiName, String fieldAPIName, String fieldsString) {
        Map<String, String> response = new Map<String, String>();
        try {
            //Check if Id field exists in given fields list
            if((fieldsString).toLowerCase().contains('id') == false) {
                fieldsString = 'Id, '+fieldsString;
            } 
            //There is a possibility of entering duplicates, so remove them before running the query
            List<String> uniqueFieldsStringList = new List<String>(new Set<String>(fieldsString.split(',')));
            String uniqueFieldsString = String.join(uniqueFieldsStringList, ',');

            String soqlString = 'SELECT '+String.escapeSingleQuotes(uniqueFieldsString)+' FROM '+String.escapeSingleQuotes(childObjectApiName);
            soqlString+= ' WHERE '+String.escapeSingleQuotes(fieldAPIName)+'=\''+String.escapeSingleQuotes(parentRecordId)+'\'';
            List<SObject> recordList = (List<SObject>) Database.query(soqlString);
            response.put('status', 'success');
            response.put('data', String.valueOf(JSON.serialize(recordList)));
        } catch(Exception e) {
            response.put('status', 'error');
            response.put('data', e.getMessage());
        }
        return response;
    }
}