class Badge {
    public String print(Integer id, String name, String department) {
	String prefix;
        if (id == null) {
	    prefix = "";
	} else {
	    prefix = "[" + id + "] - ";
	}
	String suffix;
	if (department == null) {
	    suffix = " - OWNER";
	} else {
	    suffix = " - " + department.toUpperCase();
	}
	return prefix + name + suffix;
    }
}
