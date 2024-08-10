SELECT 

    --Fact GL Train
    GL.FactGLTranID,
    GL.GLTranAmount,
    GL.JournalID,
    GL.GLTranDate,
    GL.GLTranDescription

    --GL Accounts
    AlternateKey,
    ACC.GLAcctName,
    ACC.Statement,
    ACC.Category,
    ACC.Subcategory

    --Stores
    AlternateKey,
    STOR.StoreName
    ManagerID,
    STOR.PreviousManagerID,
    STOR.ContactTel,
    STOR.AddressLine1,
    STOR.AddressLine2,
    STOR.ZipCode
    
    --Region
    AlternateKey,
    REG.RegionName,
    REG.SalesRegionName

   -- CONVERT(DATETIME, GETDATE() at time zone 'UTC' at time zone 'Central Standard Time') AS LastRefreshDate



FROM FactGLTran as GL 
    INNER JOIN dimGLAcct as ACC on GL.GLAcctID = ACC.GLAcctID
    INNER JOIN dimStore as STOR on GL.StoreID = STOR.StoreID
    INNER JOIN dimRegion as REG on STOR.RegionID = REG.RegionID
