# Celebal-Assignment-7

# 🔄 Daily Truncate Load Pipeline using Azure Data Factory

This project demonstrates an automated daily truncate-load pipeline using Azure Data Factory (ADF) that ingests three different types of files from a Data Lake container, applies conditional logic and transformations using data flows, and loads the processed data into SQL tables.

---

## 📁 Input File Types

The pipeline processes the following three types of files stored in a raw container:

1. **CUST_MSTR_YYYYMMDD.csv**
2. **master_child_export-YYYYMMDD.csv**
3. **H_ECOM_ORDER.csv**

Each file can have multiple versions for different dates.

---

## 🛠️ Pipeline Logic and Flow

1. **Get Metadata**  
   The pipeline lists and identifies the files present in the raw input folder.

2. **ForEach Loop**  
   Iterates through each file and checks the file type using `If Conditions`.

3. **Set Variables**  
   Extracts the date and date key from the filename using expressions and stores them in variables.

4. **Conditional Branching via If Condition**  
   Based on the file name:
   - **If CUST_MSTR** → Call `Data Flow 1`
   - **If master_child_export** → Call `Data Flow 2`
   - **If H_ECOM_ORDER** → Call `Data Flow 3`

5. **Data Flows**  
   - **CUST_MSTR**: Adds a new column `Date` from the file name in `YYYY-MM-DD` format.
   - **master_child_export**: Adds two new columns:
     - `Date` (format: `YYYY-MM-DD`)
     - `DateKey` (format: `YYYYMMDD`)
   - **H_ECOM_ORDER**: Loaded directly with no changes.

6. **Sink**  
   Transformed files are written into the raw output location with folder structure dynamically built based on file type.

---

## 📂 Output Folder Structure

New folders are created in the **raw output path**, based on the type of the file.  
For example:
- A file named `master_child_export-20191112.csv` will be saved in the `rawoutput/master_child/` folder.
- A file named `CUST_MSTR_20191112.csv` will go into `rawoutput/CUST_MSTR/`.

---

## 🧪 Output Validation

Post-transformation, output files can be validated as follows:

- **CUST_MSTR**
  - ➕ One new column: `Date` (`YYYY-MM-DD`)
  - Original structure is preserved, just with one extra column

- **master_child_export**
  - ➕ Two new columns:
    - `Date` (`YYYY-MM-DD`)
    - `DateKey` (`YYYYMMDD`)

- **H_ECOM_ORDER**
  - ➖ No new columns; file is loaded as-is

---

## 🐞 Debugging

Before publishing or scheduling the pipeline, run it in **Debug** mode to validate:
- Variable extraction
- Branching logic
- Data flow transformations
- Folder structure in output container

This helps ensure that all branches behave correctly for various file formats and filenames.

---

## 🗓️ Load Type

This pipeline performs a **daily truncate load**.  
Each day’s new files will replace the previous content in the destination tables or folders.

---

## 📌 Summary

✅ Built a robust ADF pipeline that dynamically handles multiple file types  
✅ Used metadata, expressions, conditional branching, and data flows  
✅ Extracted dynamic values from filenames  
✅ Created flexible folder structures in output  
✅ Ensured correct transformation logic per file type  
✅ Designed for daily batch-based truncate-load

---

