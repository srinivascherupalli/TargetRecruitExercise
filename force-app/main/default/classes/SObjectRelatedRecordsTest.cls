@isTest
public class SObjectRelatedRecordsTest {
    
    //Success response
    @isTest
    public static void testGetRelatedRecordsByParentId() { 
        Test.startTest();
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;

        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.FirstName = 'test1';
        con.LastName = 'test2';
        con.Email = 'test@test.com';
        con.AccountId = acc.Id;
        conList.add(con);
        insert conList;
        System.debug(conList);

        Map<String, String> response = SObjectRelatedRecords.getRelatedRecordsByParentId(acc.Id, 'Contact', 'AccountId', 'FirstName,LastName, Email');
        System.assertEquals(response.get('status'), 'true', 'Testing with correct values which gives success response');
        Test.stopTest();
    }
    
    //Error response
    @isTest
    public static void testGetRelatedRecordsByParentIdErrorResponse() { 
        Test.startTest();
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;

        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.FirstName = 'test1';
        con.LastName = 'test2';
        con.Email = 'test@test.com';
        con.AccountId = acc.Id;
        conList.add(con);
        insert conList;
        System.debug(conList);

        Map<String, String> response = SObjectRelatedRecords.getRelatedRecordsByParentId(acc.Id, 'Contact', 'AccountId', 'FirstName.LastName, Email');
        System.assertEquals(response.get('status'), 'error', 'Testing with incorrect values which gives error response');
        Test.stopTest();
    }
}