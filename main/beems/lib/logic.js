'use strict';

/**
 * Write your transction processor functions here
 */

function doAddDigitalSignature (addDigitalSignature) {
    //TODO.

    //I dunno how Composer works for C---. Just dump it? >_>
}

function doGetDigitalSignature (getDigitalSignature) {
    //TODO.

    //Get the Digital Signature list.
    //Check by TID, return full list.
    return getAssetRegistry('org.bit.beems.DigitalSignature')
        .then()
}

/**
 * Sample transaction
 * @param {org.bit.beems.ChangeAssetValue} changeAssetValue
 * @transaction

function onChangeAssetValue(changeAssetValue) {
    var assetRegistry;
    var id = changeAssetValue.relatedAsset.assetId;

    return getAssetRegistry('org.bit.beems.SampleAsset')
        .then(function(ar) {
            assetRegistry = ar;
            return assetRegistry.get(id);
        })
        .then(function(asset) {
            asset.value = changeAssetValue.newValue;
            return assetRegistry.update(asset);
        });
}

*/