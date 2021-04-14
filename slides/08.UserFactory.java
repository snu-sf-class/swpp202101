interface UserI {
    public void print();
}

interface UserNewI {
    public UserI makeUser(String name, String address);
    public UserI makeVIP(String name, String address, String account, Boolean prettyPrinting);
}

interface UserForVIPI extends UserI {
    public String getName();
    public String getAddress();
}

interface UserNewForVIPI {
    public UserForVIPI makeUser(String name, String address);
}

class User implements UserForVIPI {
    private String name;
    private String address;

    public User(String name, String address) {
	this.name = name;
	this.address = address;
    }

    public String getName() { return name; }
	
    public String getAddress() { return address; }
    
    public void print() {
	System.out.println(name);
	System.out.println(address);
    }
}

class UserNewForVIP implements UserNewForVIPI {
    public UserForVIPI makeUser(String name, String address) {
	return new User(name, address);
    }
}

class VIP implements UserI {
    private UserForVIPI user;
    private String account;
    private Boolean prettyPrinting;

    public VIP(UserNewForVIPI factory,
	       String name, String address, String account, Boolean prettyPrinting) {
	user = factory.makeUser(name, address);
	this.account = account;
	this.prettyPrinting = prettyPrinting;
    }
    
    public void print() {
	if (prettyPrinting) {
	    System.out.println("Name: " + user.getName());
	    System.out.println("Address: " + user.getAddress());
	    System.out.println("Account: " + account);
	} else {
	    user.print();
	    System.out.println(account);
	}
    }
}

class UserNew implements UserNewI {
    public UserI makeUser(String name, String address) {
	return new User(name, address);
    }
    public UserI makeVIP(String name, String address, String account, Boolean prettyPrinting) {
	return new VIP(new UserNewForVIP(),
		       name, address, account, prettyPrinting);
    }
}

class Main {
    static void printUser(UserI user) {
	user.print();
    }
    public static void main(String[ ] args) {
	UserNewI uf = new UserNew();
	UserI user = uf.makeUser("sunghwan","SNU");
	UserI vip = uf.makeVIP("gil", "SNU", "1234", false);
	UserI vip2 = uf.makeVIP("hur", "KAIST", "5678", true);

	printUser(user);
	printUser(vip);
	printUser(vip2);
    }
}
