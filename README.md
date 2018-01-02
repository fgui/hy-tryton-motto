# motto company

(learning tryton by doing part 5)

Creates a model motto which is only visible for the company selected.

There is a domain in the model motto.hy to limit the selection of companies when creating a model.

There is a rule via domain in motto.xml that will be inserted to the database ir.rule.group/ir.rule that warraties that only motto's of the user company will be pulled from the database

```xml
    <record model="ir.rule.group" id="rule_group_motto">
      <field name="model" search="[('model', '=', 'motto')]"/>
      <field name="global_p" eval="True"/>
    </record>
    <record model="ir.rule" id="rule_motto1">
      <field name="domain"
             eval="[('company', '=', Eval('user', {}).get('company', None))]"
             pyson="1"/>
      <field name="rule_group" ref="rule_group_motto"/>
    </record>
```

The resulting SQL when pulling list of mottos will look like something like:

```sql
SELECT ... FROM "motto" AS "a" WHERE (true AND (((("a"."company" = 7))))) ORDER BY "a"."id" ASC LIMIT 1000
```

In this case 7 is the id of company of the user performing the request.
