f = open("./../02_data/abstract-Molecularb-set.txt", "r")
auth_info = 0
address = []
PMID = []
for lines in f:
    data_split = lines.rstrip().split(":")
    
    if(auth_info == 1):
        if(lines.rstrip() == ""):
            auth_info = 0
        else:
            info = lines.rstrip().split("(" + str(aff) + ")")
            if(len(info) > 1):
                address.append(info[1])
                aff = aff + 1
            else:
                address[len(address)-1] = address[len(address)-1] + " " + lines.rstrip()
    
    else:     
        if(data_split[0] == "Author information"):
            auth_info = 1
            aff = 1
        if(data_split[0] == "PMID"):
            ID = data_split[1].rstrip().split(" ")
            PMID = PMID + [ID[1]]*(aff-1)
            aff = 1
f.close()

o = open("./../03_results/address_pmid_info.tsv", "w")
for i in range(len(address)):
    o.write(address[i])
    o.write("\t")
    o.write(PMID[i])
    o.write("\n")
o.close()

    
