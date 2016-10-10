function result_AM = train_associative_memory(data, target)
	result_AM = target * pinv(data);
end