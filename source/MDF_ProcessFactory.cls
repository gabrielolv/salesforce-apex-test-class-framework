@isTest
public class MDF_ProcessFactory {

    public class MDF_ProcessBuilder {
        private Account account;
        private Product2 product2;
        private PricebookEntry pricebookEntry;
        private Opportunity opportunity;
        private OpportunityLineItem opportunityLineItem;

        public MDF_ProcessBuilder withAccount(String recordTypeDeveloperName, String source) {
            this.account = MDF_AccountFactory.start()
                .withRecordType(recordTypeDeveloperName)
                .withAccountSource(source)
                .withBillingAddress()
                .create();
            return this;
        }

        public MDF_ProcessBuilder withProduct() {
            this.product2 = MDF_Product2Factory.start()
                .withProductCode()
                .create();
            return this;
        }

        public MDF_ProcessBuilder withPricebookEntry() {
            if (this.product2 == null) {
                this.withProduct();
            }
            this.pricebookEntry = MDF_PricebookEntryFactory.start()
                .withStandardPricebook()
                .relatedService(this.product2)
                .withUnitPrice()
                .inActiveStatus()
                .create();
            return this;
        }

        public MDF_ProcessBuilder withOpportunity(/*String recordTypeDeveloperName*/) {
            if (this.account == null) {
                this.withAccount('Business_Account','Partner Referral');
            }
            this.opportunity = MDF_OpportunityFactory.start()
                .relatedAccount(this.account)
                .withPricingInformation()
                .withRecordType(recordTypeDeveloperName)
                .withCloseDateToday()
                .create();
            return this;
        }

        public MDF_ProcessBuilder withOpportunityLineItem() {
            if (this.opportunity == null) {
                this.withOpportunity('Opp_Record_Type');
            }
            if (this.pricebookEntry == null) {
                this.withPricebookEntry();
            }
            this.opportunityLineItem = MDF_OpportunityLineItemFactory.start()
                .relatedOpportunity(this.opportunity)
                .withPricingInformation(this.pricebookEntry)
                .withQuantity()
                .withTotalPrice()
                .create();
            return this;
        }

        public TestData build() {
            return new TestData(this.account, this.product2, this.pricebookEntry, this.opportunity, this.opportunityLineItem);
        }
    }

    public class TestData {
        public Account account;
        public Product2 product2;
        public PricebookEntry pricebookEntry;
        public Opportunity opportunity;
        public OpportunityLineItem opportunityLineItem;

        public TestData(Account acc, Product2 pdt2, PricebookEntry pbe, Opportunity opp, OpportunityLineItem oli) {
            this.account = acc;
            this.product2 = pdt2;
            this.pricebookEntry = pbe;
            this.opportunity = opp;
            this.opportunityLineItem = oli;
        }
    }

    public static MDF_ProcessBuilder start() {
        return new MDF_ProcessBuilder();
    }
}