'use strict';

/**
 * Add the digital signature to the blockchain
 * BROKEN. DO NOT USE FOR NOW. NO IDEA WHY IT IS NOT INSIDE THE ASSET REGISTRY.
 * @param {org.bit.beems.addDigitalSignature} digitalSignature - the digital signature to be processed
 * @transaction
 */

function addDigitalSignature (digitalSignature) {
    var blockchainLocation = "org.bit.beems";
    var assetName = "DigitalSignature";
    
    // Get the DigitalSignature registry.
    return getAssetRegistry(blockchainLocation + '.' + assetName)
        .then(function (digitalSignatureAssetRegistry) {
            // Get the factory for creating new asset instance.
            var factory = getFactory();

            // Create the digital signature.
            var ds = factory.newResource(blockchainLocation, assetName, digitalSignature.id);
            ds.encryptedSignatureHash = digitalSignature.encryptedSignatureHash;
            ds.publicKey = digitalSignature.publicKey;
            
            // Emit a notification event that a digital signature is added
            var addNotification = factory.newEvent(blockchainLocation, assetName);
            addNotification.digitalSignature = ds;
            emit(addNotification);
            
            // Add the given digital signature to the DigitalSignature registry
            return digitalSignatureAssetRegistry.add(ds);
        })
        .catch(function (error) {
            // Add optional error handling here.
        });
}