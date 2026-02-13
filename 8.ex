1.java 
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.*;

import java.time.Duration;
import java.util.List;

public class EcommerceTestNGSuite {

    WebDriver driver;
    WebDriverWait wait;

    @BeforeClass
    public void setup() {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        driver = new ChromeDriver(options);   // ✅ No System.setProperty
        driver.manage().window().maximize();

        wait = new WebDriverWait(driver, Duration.ofSeconds(20));
    }

    // ================= REGISTER =================
    @Test(priority = 1)
    public void testRegister() {

        driver.get("https://mathankumar8248097868-cloud.github.io/ex3web/register.html");

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")))
                .sendKeys("Test User");

        driver.findElement(By.id("email")).sendKeys("test@gmail.com");
        driver.findElement(By.id("password")).sendKeys("1234");
        driver.findElement(By.id("confirm")).sendKeys("1234");
        driver.findElement(By.tagName("button")).click();

        wait.until(ExpectedConditions.urlContains("login.html"));

        Assert.assertTrue(driver.getCurrentUrl().contains("login.html"));
        System.out.println("✅ REGISTER SUCCESSFUL");
    }

    // ================= LOGIN =================
    @Test(priority = 2)
    public void testLogin() {

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("email")))
                .sendKeys("test@gmail.com");

        driver.findElement(By.id("password")).sendKeys("1234");
        driver.findElement(By.tagName("button")).click();

        wait.until(ExpectedConditions.urlContains("products.html"));

        Assert.assertTrue(driver.getCurrentUrl().contains("products.html"));
        System.out.println("✅ LOGIN SUCCESSFUL");
    }

    // ================= SEARCH =================
    @Test(priority = 3)
    public void testSearchProduct() throws InterruptedException {

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchInput")))
                .sendKeys("Mobile");

        driver.findElement(By.className("search-btn")).click();

        Thread.sleep(1000);

        List<WebElement> products = driver.findElements(By.className("card"));

        boolean found = false;

        for (WebElement product : products) {
            if (product.isDisplayed()) {
                String name = product.findElement(By.tagName("h3")).getText();
                if (name.equalsIgnoreCase("Mobile")) {
                    found = true;
                    break;
                }
            }
        }

        Assert.assertTrue(found);
        System.out.println("✅ SEARCH TEST PASSED");
    }

    // ================= ADD TO CART =================
    @Test(priority = 4)
    public void testAddToCart() {

        WebElement product = driver.findElements(By.className("card")).get(0);
        WebElement addBtn = product.findElement(By.className("add-btn"));

        ((JavascriptExecutor) driver)
                .executeScript("arguments[0].click();", addBtn);

        wait.until(ExpectedConditions.alertIsPresent());
        Alert alert = driver.switchTo().alert();
        alert.accept();

        wait.until(ExpectedConditions.urlContains("cart.html"));

        Assert.assertTrue(driver.getCurrentUrl().contains("cart.html"));
        System.out.println("✅ PRODUCT ADDED TO CART");
    }

    // ================= CHECKOUT =================
    @Test(priority = 5)
    public void testProceedCheckout() {

        wait.until(ExpectedConditions.elementToBeClickable(
                By.xpath("//button[contains(text(),'Proceed')]"))).click();

        wait.until(ExpectedConditions.urlContains("checkout.html"));

        Assert.assertTrue(driver.getCurrentUrl().contains("checkout.html"));
        System.out.println("✅ CHECKOUT PAGE OPENED");
    }

    // ================= PAYMENT =================
    @Test(priority = 6)
    public void testPayment() {

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("card")))
                .sendKeys("123");

        driver.findElement(By.id("cvv")).sendKeys("123");
        driver.findElement(By.tagName("button")).click();

        wait.until(ExpectedConditions.urlContains("index.html"));

        Assert.assertTrue(driver.getCurrentUrl().contains("index.html"));
        System.out.println("✅ PAYMENT SUCCESSFUL");
    }

    @AfterClass
    public void tearDown() {
        driver.quit();
    }
}
----------------------------------------
2.xml

<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>org.example</groupId>
    <artifactId>EcommerceTestNG</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <dependencies>

        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>4.18.1</version>
        </dependency>

        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>7.9.0</version>
            <scope>test</scope>
        </dependency>

    </dependencies>

</project>
