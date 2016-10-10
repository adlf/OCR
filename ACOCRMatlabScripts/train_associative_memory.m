function result_AM = train_associative_memory(data, target, transpose)
	result_AM = target * pinv(data);
end