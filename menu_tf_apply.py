import os

# Mapping between menu numbers and module targets (no VPC)
MODULE_TARGETS = {
    "1": "module.webserver",
    "2": "module.rds",
    "3": "module.redshift"
}

def show_menu():
    print("\nChoose which module(s) to apply (use comma-separated list):")
    print("1 - Webserver")
    print("2 - RDS")
    print("3 - Redshift")
    print("4 - Apply All (excluding VPC)")
    print("0 - Exit")

def run_terraform_command(targets):
    if not targets:  # Apply all non-VPC modules if no specific targets are chosen
        os.system("terraform apply -target=module.webserver -target=module.rds -target=module.redshift")
    else:
        target_args = " ".join([f"-target={target}" for target in targets])
        os.system(f"terraform apply {target_args}")

def main():
    while True:
        show_menu()
        choice = input("Enter your choice (e.g., 1,3 or 4 for all): ").strip()

        if choice == "0":
            print("Exiting...")
            break
        elif choice == "4":
            run_terraform_command([])  # Apply all (excluding VPC)
        else:
            selected_modules = choice.split(",")
            selected_targets = []

            for module_number in selected_modules:
                module_number = module_number.strip()
                if module_number in MODULE_TARGETS:
                    selected_targets.append(MODULE_TARGETS[module_number])
                else:
                    print(f"Invalid selection: {module_number}")
                    break
            else:
                run_terraform_command(selected_targets)

if __name__ == "__main__":
    main()

