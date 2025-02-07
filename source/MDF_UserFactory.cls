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
public class MDF_UserFactory {

    private User current;
 
    public MDF_UserFactory(User current) {
        this.current = current;
    }

    public static MDF_UserFactory start() {
        return new MDF_UserFactory(
            new User( Alias = 'testUser', LastName = 'Test', UserName = 'testuser' + System.currentTimeMillis() + '@example.com')
        );
    }

    public MDF_UserFactory withEmail() {
        this.current.Email = 'testuser@example.com';
        return this;
    }

    public MDF_UserFactory withProfile(String profile) {
        Profile p = [SELECT Id FROM Profile WHERE Name = :profile LIMIT 1];
        this.current.ProfileId = p.Id;
        return this;
    }

    public MDF_UserFactory withLocaleSettings() {
        this.current.LanguageLocaleKey = 'en_US';
        this.current.EmailEncodingKey = 'UTF-8';
        this.current.LocaleSidKey = 'en_US';
        this.current.TimeZoneSidKey = 'America/Los_Angeles';
        return this;
    }
    public User create() {
        insert current;
        return current;
    }

    public SObject getObject() {
        return [SELECT Id FROM User WHERE LastName = 'Test' AND Email = 'testuser@example.com' AND isActive = true LIMIT 1];
    }
}