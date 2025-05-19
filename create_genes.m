function genes = create_genes(len)
random_number = randi ([32,126],1,len); %randi adalah perintah memunculkan random number
genes = char(random_number);
end