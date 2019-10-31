function H = shape(object)

[rows,cols] = find(object == l);
centroid = [round(mean(rows))  round(mean(cols))];

lowR = min(rows);
highR = max(rows);

lowC = min(cols);
highC = max(cols);

