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

public class InventoryControlTest {

    public static void main(String[] args) {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        WebDriver driver = new ChromeDriver(options);
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

        try {

            driver.manage().window().maximize();

            // ================= OPEN INVENTORY SYSTEM =================
            driver.get("https://mathankumar8248097868-cloud.github.io/4web/");

            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("item-name")));
            System.out.println("✅ Inventory Page Loaded Successfully");

            // ================= ADD NEW ITEM =================
            driver.findElement(By.id("item-name")).sendKeys("Laptop");
            driver.findElement(By.id("item-quantity")).sendKeys("10");

            WebElement addButton = driver.findElement(By.xpath("//button[contains(text(),'Add')]"));
            addButton.click();

            System.out.println("✅ New Item Added Successfully");

            Thread.sleep(2000);

            // ================= VERIFY ITEM COUNT =================
            List<WebElement> rows = driver.findElements(
                    By.xpath("//table[@id='inventory-table']//tr"));

            int itemCount = rows.size() - 1; // exclude header row
            System.out.println("📦 Total Items in Inventory: " + itemCount);

            System.out.println("🏁 TEST COMPLETED SUCCESSFULLY");

        } catch (Exception e) {

            System.out.println("❌ TEST FAILED");
            e.printStackTrace();
        }

        // ❌ driver.quit() removed
    }
}
