import random
import numpy as np
import pandas as pd

file_path = '/content/drive/MyDrive/PSO/DM 5 tahun terakhir.xlsm'
sheet_name = 'Data Madu'

xls = pd.ExcelFile(file_path)
df_temp = xls.parse(sheet_name)
for i, row in df_temp.iterrows():
    if 'Tahun' in row.values:
        header_row_index = i
        break

df = pd.read_excel(file_path, sheet_name=sheet_name, header=header_row_index)
df = df[pd.to_numeric(df['Unnamed: 6'], errors='coerce').notnull()]
df['Average_Price'] = pd.to_numeric(df['Unnamed: 6'], errors='coerce')

average_price = df['Average_Price'].mean()

max_demand_kg = 100000    
max_storage_kg = 80000    

pounds_per_kg = 2.20462
max_demand_lb = max_demand_kg * pounds_per_kg
max_storage_lb = max_storage_kg * pounds_per_kg

class Particle:
    def __init__(self, position):
        self.position = position
        self.velocity = np.zeros_like(position)
        self.best_position = position
        self.best_fitness = float('inf')

# Fungsi Tujuan
def F_real(x):
    colonies = x[0]
    yield_per_colony = x[1]
    production = colonies * yield_per_colony
    profit = production * average_price

    penalty = 0
    if production > max_demand_lb:
        penalty += 1e6
    if production > max_storage_lb:
        penalty += 1e6

    return -profit + penalty  # Negatif untuk maksimalkan

# Algoritma PSO
def PSO(ObjF, Pop_Size, D, MaxT):
    swarm_best_position = None
    swarm_best_fitness = float('inf')
    particles = []


    lower_bounds = np.array([1000, 10])         # [colonies, yield]
    upper_bounds = np.array([50000, 100])

    for _ in range(Pop_Size):
        position = np.random.uniform(lower_bounds, upper_bounds)
        particle = Particle(position)
        particles.append(particle)

        fitness = ObjF(position)
        if fitness < swarm_best_fitness:
            swarm_best_fitness = fitness
            swarm_best_position = position
            particle.best_position = position
            particle.best_fitness = fitness

    for itr in range(MaxT):
        for particle in particles:
            w = 0.8
            c1 = 1.2
            c2 = 1.2

            r1 = random.random()
            r2 = random.random()

            particle.velocity = (
                w * particle.velocity +
                c1 * r1 * (particle.best_position - particle.position) +
                c2 * r2 * (swarm_best_position - particle.position)
            )

            particle.position += particle.velocity
            particle.position = np.clip(particle.position, lower_bounds, upper_bounds)

            fitness = ObjF(particle.position)

            if fitness < particle.best_fitness:
                particle.best_fitness = fitness
                particle.best_position = particle.position

            if fitness < swarm_best_fitness:
                swarm_best_fitness = fitness
                swarm_best_position = particle.position

    return swarm_best_position, swarm_best_fitness

def F1(x): return np.sum(x ** 2)
def F2(x): return np.max(np.abs(x))

Objective_Function = {
    'F1': F1,
    'F2': F2,
    'RealProfit': F_real 
}

Pop_Size = 30
MaxT = 100
D = 2 


for funName, ObjF in Objective_Function.items():
    if funName != 'RealProfit':
        continue  

    Output = "Running Function = " + funName + "\n"
    best_position, best_fitness = PSO(ObjF, Pop_Size, D, MaxT)
    best_colonies = best_position[0]
    best_yield = best_position[1]
    production = best_colonies * best_yield
    profit = -best_fitness

    Output += f"BEST Colonies         : {best_colonies:.2f}\n"
    Output += f"BEST Yield per Colony : {best_yield:.2f}\n"
    Output += f"Total Production (lbs): {production:.2f}\n"
    Output += f"Estimated Profit ($)  : {profit:.2f}"

    print(Output)