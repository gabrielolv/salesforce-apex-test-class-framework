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
public class MDF_OpportunityFactory {
    private Opportunity current;

    public MDF_OpportunityFactory(Opportunity current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_OpportunityFactory start() {
        return new MDF_OpportunityFactory(
            new Opportunity( Name = 'Test Opportunity')
        );
    }

    // Composable Functions
    public MDF_OpportunityFactory relatedAccount(Account account) {
        this.current.AccountId = account.Id;
        return this;
    }

    public MDF_OpportunityFactory withStage(String stage) {
        this.current.StageName = stage;
        return this;
    }
    
    public MDF_OpportunityFactory withCloseDateToday() {
        this.current.CloseDate = Date.today();
        return this;
    }
    
    public MDF_OpportunityFactory withRecordType(String recordTypeDeveloperName) {
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(recordTypeDeveloperName).getRecordTypeId();
        this.current.RecordTypeId = recordTypeId;
        return this;
    }

    public MDF_OpportunityFactory withPricingInformation() {
        this.current.Pricebook2Id = Test.getStandardPricebookId();
        return this;
    }

    public Opportunity create() {
        insert current;
        return current;
    }

    public static Opportunity getObject() {      
        return [SELECT Id,RecordTypeId,Name,StageName,CloseDate,Pricebook2Id,AccountId FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
    }
}