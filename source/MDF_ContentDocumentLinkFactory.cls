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
public class MDF_ContentDocumentLinkFactory {

    private ContentDocumentLink current;
 
    public MDF_ContentDocumentLinkFactory(ContentDocumentLink current) {
        this.current = current;
    }

    public static MDF_ContentDocumentLinkFactory start() {
        return new MDF_ContentDocumentLinkFactory(
            new ContentDocumentLink(ShareType = 'V')
        );
    }
    public MDF_ContentDocumentLinkFactory relatedContentDocument(Id contentDocumentId) {
        this.current.ContentDocumentId = contentDocumentId;
        return this;
    }
    public MDF_ContentDocumentLinkFactory relatedLinkedEntityId(Id linkedId) {
        this.current.LinkedEntityId = linkedId;
        return this;
    }
    public ContentDocumentLink create() {
        insert current;
        return current;
    }
    public static ContentDocumentLink getObjectByContentDocument(Id contentDocumentId) {
        return [SELECT Id,ContentDocumentId,LinkedEntityId,ShareType FROM ContentDocumentLink WHERE ContentDocumentId=:contentDocumentId LIMIT 1];
    }
}