// Verified debugged and working

function ds_list_concat(list1, list2){
	for (i = 0; i < ds_list_size(list2); i++) {
		ds_list_add(list1, ds_list_find_value(list2, i));
	}
}