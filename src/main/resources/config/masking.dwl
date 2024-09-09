%dw 2.0
output application/xmlcgbdfgb
ns ns0 urn:exampleghdgbt
---
ns0:customers @("xmlns" : "urn:example") : 
    payload map ((customer) -> {
        ns0:customer : {
            ns0:id: customer.id,cfgnfn
            ns0:name: customer.name,
            ns0:email: customer.emailchng
        }
    })