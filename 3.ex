1.java

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;

public class SearchMobileTest {

    public static void main(String[] args) {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        WebDriver driver = new ChromeDriver(options);
        driver.manage().window().maximize();

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

        try {

            // ================= OPEN REGISTER PAGE =================
            driver.get("https://mathankumar8248097868-cloud.github.io/ex3web/register.html");

            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("name")))
                    .sendKeys("Mathan Kumar");

            driver.findElement(By.id("email")).sendKeys("mathan@gmail.com");
            driver.findElement(By.id("password")).sendKeys("1234");
            driver.findElement(By.id("confirm")).sendKeys("1234");
            driver.findElement(By.tagName("button")).click();

            wait.until(ExpectedConditions.urlContains("login.html"));
            System.out.println("REGISTER SUCCESSFUL");


            // ================= LOGIN =================
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("email")))
                    .sendKeys("mathan@gmail.com");

            driver.findElement(By.id("password")).sendKeys("1234");
            driver.findElement(By.tagName("button")).click();

            wait.until(ExpectedConditions.urlContains("products.html"));
            System.out.println("LOGIN SUCCESSFUL");


            // ================= SEARCH MOBILE =================
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchInput")))
                    .sendKeys("Mobile");

            driver.findElement(By.className("search-btn")).click();

            // Wait small time for filter
            Thread.sleep(1000);

            // ================= VERIFY SEARCH RESULT =================
            List<WebElement> products =
                    driver.findElements(By.className("card"));

            boolean mobileFound = false;

            for (WebElement product : products) {
                if (product.isDisplayed()) {
                    String name = product.findElement(By.tagName("h3")).getText();
                    System.out.println("VISIBLE PRODUCT: " + name);

                    if (name.equalsIgnoreCase("Mobile")) {
                        mobileFound = true;
                    }
                }
            }

            if (mobileFound) {
                System.out.println("SEARCH TEST PASSED ✅ Mobile displayed");
            } else {
                System.out.println("SEARCH TEST FAILED ❌ Mobile not found");
            }

        } catch (Exception e) {
            System.out.println("TEST ERROR");
            e.printStackTrace();
        }

        // 🔥 NO driver.quit() so browser stays open
    }
}
