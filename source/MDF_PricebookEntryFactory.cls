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
public class MDF_PricebookEntryFactory {

    private PricebookEntry current;
 
    public MDF_PricebookEntryFactory(PricebookEntry current) {
        this.current = current;
    }

    public static MDF_PricebookEntryFactory start() {
        return new MDF_PricebookEntryFactory(
            new PricebookEntry()
        );
    }
    
    public MDF_PricebookEntryFactory relatedService(Product2 service) {
        this.current.Product2Id = service.Id;
        return this;
    }

    public MDF_PricebookEntryFactory withStandardPricebook() {
        this.current.Pricebook2Id = Test.getStandardPricebookId();
        return this;
    }

    public MDF_PricebookEntryFactory withUnitPrice() {
        this.current.UnitPrice = 100;
        return this;
    }

    public MDF_PricebookEntryFactory inActiveStatus() {
        this.current.IsActive = true;
        return this;
    }

    public PricebookEntry create() {
        insert current;
        return current;
    }

    public static PricebookEntry getObject() {
            return [SELECT Id, Product2Id, Pricebook2Id, UnitPrice, IsActive FROM PricebookEntry LIMIT 1];
    }
}