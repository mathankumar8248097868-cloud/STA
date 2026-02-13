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

import java.time.Duration;
import java.util.List;

public class EcommerceSearchAddPaymentTest {

    public static void main(String[] args) {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        WebDriver driver = new ChromeDriver(options);
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

        try {

            driver.manage().window().maximize();

            // ================= REGISTER =================
            driver.get("https://mathankumar8248097868-cloud.github.io/ex3web/register.html");


            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")))
                    .sendKeys("Mathan Kumar");

            driver.findElement(By.id("email")).sendKeys("mathan@gmail.com");
            driver.findElement(By.id("password")).sendKeys("1234");
            driver.findElement(By.id("confirm")).sendKeys("1234");
            driver.findElement(By.tagName("button")).click();

            wait.until(ExpectedConditions.urlContains("login.html"));
            System.out.println("✅ REGISTER SUCCESSFUL");


            // ================= LOGIN =================
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("email")))
                    .sendKeys("mathan@gmail.com");

            driver.findElement(By.id("password")).sendKeys("1234");
            driver.findElement(By.tagName("button")).click();

            wait.until(ExpectedConditions.urlContains("products.html"));
            System.out.println("✅ LOGIN SUCCESSFUL");


            // ================= SEARCH PRODUCT =================
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchInput")))
                    .sendKeys("Mobile");

            driver.findElement(By.className("search-btn")).click();

            Thread.sleep(1000); // allow filter

            // ================= VERIFY SEARCH RESULT =================
            List<WebElement> products = driver.findElements(By.className("card"));

            int visibleCount = 0;
            WebElement targetProduct = null;

            for (WebElement product : products) {
                if (product.isDisplayed()) {
                    visibleCount++;
                    String name = product.findElement(By.tagName("h3")).getText();
                    System.out.println("🔎 Visible Product: " + name);

                    if (name.equalsIgnoreCase("Mobile")) {
                        targetProduct = product;
                    }
                }
            }

            System.out.println("📦 Total Visible Products: " + visibleCount);

            if (targetProduct != null) {
                System.out.println("✅ SEARCH TEST PASSED");
            } else {
                System.out.println("❌ SEARCH TEST FAILED");
                return;
            }


            // ================= ADD TO CART =================
            WebElement addBtn = targetProduct.findElement(By.className("add-btn"));

            ((JavascriptExecutor) driver)
                    .executeScript("arguments[0].click();", addBtn);

            System.out.println("✅ PRODUCT ADDED BUTTON CLICKED");


            // Handle alert
            wait.until(ExpectedConditions.alertIsPresent());
            Alert alert = driver.switchTo().alert();
            System.out.println("ALERT: " + alert.getText());
            alert.accept();


            // Wait for redirect to cart
            wait.until(ExpectedConditions.urlContains("cart.html"));
            System.out.println("✅ CART PAGE OPENED");


            // ================= CHECKOUT =================
            wait.until(ExpectedConditions.elementToBeClickable(
                    By.xpath("//button[contains(text(),'Proceed')]"))).click();

            wait.until(ExpectedConditions.urlContains("checkout.html"));
            System.out.println("✅ CHECKOUT PAGE OPENED");


            // ================= PAYMENT =================
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("card")))
                    .sendKeys("123");

            driver.findElement(By.id("cvv")).sendKeys("123");

            driver.findElement(By.tagName("button")).click();

            wait.until(ExpectedConditions.urlContains("index.html"));

            System.out.println("✅ PAYMENT SUCCESSFUL");
            System.out.println("🏁 TEST COMPLETED SUCCESSFULLY");


        } catch (Exception e) {

            System.out.println("❌ TEST FAILED");
            e.printStackTrace();
        }

        // driver.quit(); intentionally removed
    }
}
