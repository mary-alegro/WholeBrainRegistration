function vol2 = cut_volume(volume,ul,lr)

vol2 = volume(ul(1):lr(1), ul(2):lr(2), :);