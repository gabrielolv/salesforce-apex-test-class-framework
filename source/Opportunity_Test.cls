@isTest
public class Opportunity_Test {
    @testSetup
    static void setup(){
        User testUser = MDF_UserFactory.start()
        .withEmail()
        .withProfile('System Administrator')
        .withLocaleSettings()
        .create();
        System.runAs(testUser){
            MDF_FactoryOrchestrator.TestData testData = MDF_FactoryOrchestrator.start()
            .withAccount('Business_Account','Partner Referral')
            .withProduct()
            .withPricebookEntry()
            .withOpportunity('Opp_Record_Type')
            .withOpportunityLineItem()
            .build();
        }
    }

    @isTest
    static void testMethod1(){
        Test.startTest();
        List<Opportunity> newOpp = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        Test.stopTest();
        Assert.areEqual(false, newOpp.isEmpty(), 'Opportunity was not created!');       
    }

    @isTest
    static void testMethod2(){
        Test.startTest();
        List<Opportunity> newOpp = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        newOpp[0].Name = 'Test Method 2';
        update newOpp;
        List<Opportunity> oppUpdated = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Method 2' LIMIT 1];
        Test.stopTest();
        Assert.areEqual(false, oppUpdated.isEmpty(), 'Opportunity was not updated!');      
    }
}