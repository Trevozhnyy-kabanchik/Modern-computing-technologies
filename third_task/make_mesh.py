import csv

# === НАСТРОЙКИ ===
csv_filename = 'Default Dataset.csv'
geo_filename = 'mosreg_mesh.geo'

# Координаты Можайска
mozhaysk_x = 8.6654
mozhaysk_y = 21.66

lc_boundary = 1.0
lc_mozhaysk = 0.05  

points = []

with open(csv_filename, 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    for row in reader:
        try:
            x, y = float(row[0]), float(row[1])
            points.append((x, y))
        except (ValueError, IndexError):
            continue

with open(geo_filename, 'w', encoding='utf-8') as f:
    f.write('SetFactory("OpenCASCADE");\n\n')
    
    # точки границы
    for i, (x, y) in enumerate(points):
        f.write(f'Point({i+1}) = {{{x}, {y}, 0, {lc_boundary}}};\n')
    f.write('\n')
    
    # линии, соединяющие точки
    num_points = len(points)
    for i in range(1, num_points):
        f.write(f'Line({i}) = {{{i}, {i+1}}};\n')
    f.write(f'Line({num_points}) = {{{num_points}, 1}};\n\n') # замыкаем контур
    
    # Создаем контур и плоскость
    lines_str = ', '.join(str(i) for i in range(1, num_points + 1))
    f.write(f'Curve Loop(1) = {{{lines_str}}};\n')
    f.write('Plane Surface(1) = {1};\n\n')
    
    # добавляем Можайск 
    mozhaysk_id = num_points + 1
    f.write(f'// Точка сгущения: Можайск\n')
    f.write(f'Point({mozhaysk_id}) = {{{mozhaysk_x}, {mozhaysk_y}, 0, {lc_mozhaysk}}};\n')
    f.write(f'Point{{{mozhaysk_id}}} In Surface{{1}};\n')

print(f"Файл {geo_filename} готов к работе😎! В нем {num_points} точек границы")