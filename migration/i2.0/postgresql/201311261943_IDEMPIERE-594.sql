-- Nov 26, 2013 7:43:01 PM COT
-- IDEMPIERE-594 Improve positioning on windows / Fix Relation Type window layout
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-11-26 19:43:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58069
;

-- Nov 26, 2013 7:43:01 PM COT
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2013-11-26 19:43:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58066
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58067
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58075
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58071
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58072
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58073
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58074
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58064
;

-- Nov 26, 2013 7:43:02 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-11-26 19:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58070
;

SELECT register_migration_script('201311261943_IDEMPIERE-594.sql') FROM dual
;

