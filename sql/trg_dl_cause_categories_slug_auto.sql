-- Trigger to auto-generate SLUG from CATEGORY_NAME on INSERT or UPDATE
-- Keeps SLUG consistent with URL-friendly lowercase + hyphen format (spaces & special chars replaced)

CREATE OR REPLACE TRIGGER trg_dl_cause_categories_slug_trigger
BEFORE INSERT OR UPDATE OF CATEGORY_NAME ON dl_cause_categories FOR EACH ROW
DECLARE
    v_name          VARCHAR2(100);
BEGIN

    -- Skip auto-generation if SLUG is already provided (allowing manual override when needed)
    IF :NEW.SLUG IS NULL THEN
        -- Get the category name value (after INSERT or UPDATE of CATEGORY_NAME column triggers this block)
        v_name := COALESCE(:NEW.CATEGORY_NAME, '');

        -- Convert to URL-friendly slug format: lowercase + replace spaces/special chars with hyphens
        :NEW.SLUG := CASE
            WHEN LENGTH(TRIM(v_name)) = 0 THEN NULL    -- Empty category name means skip SLUG assignment
            ELSE LOWER(
                REGEXP_REPLACE(REPLACE(UPPER(TRIM(V_NAME)), '[^A-Z0-9]',''),' ','-',1,2)   -- Replace spaces & special chars with - at the start of string
             )
        END;
    END IF;
END;/trg_dl_cause_categories_slug_trigger

-- Grant EXECUTE privilege (adjust as needed for your security context):
GRANT EXECUTE ON trg_dl_cause_categories_slug_trigger TO apex_public_user, apex_admin;
