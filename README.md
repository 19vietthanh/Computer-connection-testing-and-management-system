# Computer connection testing and management system
Description: A project implemented using J2EE technology on a computer connection testing and management system. 
There is a combination of Servlet, jsp, MySQL database through jdbc.

## Setting :
- JDK: 1.8,
- Glasfish 6.0.0,
- Netbeans 20,
- Mysql in Xampp v3.3.0,
- Import Database: db_quanlymaytinh.sql

## Download Setting:
https://drive.google.com/file/d/16_pUtEpnmcSkOSHhxgKtjdxw-49FbICb/view?usp=sharing
## The project folder layout is as follows	
	Web pages
	|	- WEB-INF
	|	|	-- glassfish-web.xml
	|	|	-- web.xml
	|	- J2Map.jpg
	|	- dangky.html
	|	- dangnhap.css
	|	- dangnhap.html
	|	- favicon.ico
	|	- home.css
	|	- index.html
	|	- index.jsp
	|	- inf_user.css
	|	- inf_user.jsp
	|	- style.css
	|	- update.css
	|	- update.jsp
	Source Packages
	|	- Data
	|	|	-- User.java
	|	- Servlet
	|	|	-- Dangky.java
	|	|	-- Kiemtra.java
	|	|	-- Logout.java
	|	|	-- PingServlet.java
	|	|	-- TestConn.java
	|	|	-- Update.java
	|	|	-- chinhsuathongtin.java
	|	|	-- delete.java
	|	|	-- search.java
	|	|	-- xoamay.java
	...
## Project installation and setup
1. Download Install and unzip it
2. Install Netbean
3. Because netbean requires installation with a JDK version greater than 11, please install an additional JDK version at https://www.oracle.com/java/technologies/downloads/ to be able to use Netbean.
4. Start netbean and add glassfish-6.0.0, jdk 1.8, mysql-connector-j-8.3.0
5. Start Xampp and import db_quanlymaytinh.sql
6. Build and run the project
