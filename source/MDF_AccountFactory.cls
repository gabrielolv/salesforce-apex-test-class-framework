/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */

 @isTest
 public class MDF_AccountFactory {
     private Account current;
 
     public MDF_AccountFactory(Account current) {
         this.current = current;
     }
 
     public static MDF_AccountFactory start() {
         return new MDF_AccountFactory(
             new Account( Name = 'Test Account for Testing' )
         );
     }
 
     public MDF_AccountFactory withDescription() {
         current.Description = 'Some description';
         return this;
     }
 
     public MDF_AccountFactory withWebsite() {
         current.Website = 'www.test.com';
         return this;
     }
 
     public MDF_AccountFactory withBillingAddress() {
         //current.BillingStreet = '1355 West 3100 South';
         current.BillingCity = 'Calgary';
         //current.BillingState = 'UT';
         //current.BillingPostalCode = '84119';
         //current.BillingCountry = 'United States';
         return this;
     }
 
     public MDF_AccountFactory withShippingAddress() {
         current.ShippingStreet = '1355 West 3100 South';
         current.ShippingCity = 'West Valley City';
         current.ShippingState = 'UT';
         current.ShippingPostalCode = '84119';
         current.ShippingCountry = 'United States';
         return this;
     }
     
     public MDF_AccountFactory withRecordType(String recordTypeDeveloperName) {
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(recordTypeDeveloperName).getRecordTypeId();
        current.RecordTypeId = recordTypeId;
        return this;
    }

    public MDF_AccountFactory withAccountSource(String source) {
        current.AccountSource = source;
        return this;
    }

    public Account create() {
         insert current;
         return current;
    }

    public List<Account> createList(Integer numberOfAccounts) {
        List<Account> accList =  new List<Account>();
        for(Integer i=0; i<numberOfAccounts; i++) {
            current.Name = 'Test Account for Testing ' + i;
            accList.add(current);
        }
        insert accList;
        return accList;
    }

    public static Account getObject() {
        return [SELECT Id,Name,Description,Website,BillingCity,RecordTypeId,AccountSource FROM Account WHERE Name = 'Test Account for Testing' LIMIT 1];
    } 

    public static List<Account> getObjectList() {
        return [SELECT Id,Name,Description,Website,BillingCity,RecordTypeId,AccountSource FROM Account];
    }
 }