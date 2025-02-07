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
public class MDF_OpportunityLineItemFactory {
    private OpportunityLineItem current;

    public MDF_OpportunityLineItemFactory(OpportunityLineItem current) {
        this.current = current;
    }

    // Entry point builder method to start composing object attributes
    public static MDF_OpportunityLineItemFactory start() {
        return new MDF_OpportunityLineItemFactory(
            new OpportunityLineItem()
        );
    }

    // Composable Functions
    
    public MDF_OpportunityLineItemFactory relatedOpportunity(Opportunity opportunity) {
        this.current.OpportunityId = opportunity.Id;
        return this;
    }

    public MDF_OpportunityLineItemFactory withServiceDate() {
        this.current.ServiceDate = Date.today()+10;
        return this;
    }

    public MDF_OpportunityLineItemFactory withPricingInformation(PricebookEntry pbe) {
        this.current.PricebookEntryId = pbe.Id;
        return this;
    }

    public MDF_OpportunityLineItemFactory withQuantity() {
        this.current.Quantity = 5;
        return this;
    }

    public MDF_OpportunityLineItemFactory withTotalPrice() {
        this.current.TotalPrice = 500.00;
        return this;
    }
    
    public OpportunityLineItem create() {
        insert current;
        return current;
    }

    public static OpportunityLineItem getObject() {
        return [SELECT Id, Quantity, TotalPrice, PricebookEntryId, ServiceDate, OpportunityId FROM OpportunityLineItem LIMIT 1];
    }
}