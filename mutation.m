function[mutant] = mutation(child,mutation_rate) %menciptakan codingan mutasi dengan nama file mutasi, mutant kurung siku karena ada 2

mutant = child; 
for i=1:length(child.genes) 
    if rand <= mutation_rate % Memunculkan satu bilangan dan jika angka kurang dari mutation_rate maka mutasi terjadi
        mutant.genes(i) = char(randi([32,126]));
    end
end

end

% mutasi terjadi karena ada standarnya