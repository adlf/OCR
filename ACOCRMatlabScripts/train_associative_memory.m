function result_AM = train_associative_memory(data, target, transpose)
	if (transpose == 1)
		result_AM = target * data';
	else
		result_AM = target * pinv(data);
	end
end