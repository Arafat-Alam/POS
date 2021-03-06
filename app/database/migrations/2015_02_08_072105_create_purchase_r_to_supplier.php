<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePurchaseRToSupplier extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('PurchaseRToSuppliers', function(Blueprint $table)
		{
			$table->increments('i_sup_return_id');
                        $table->integer('sup_r_invoice_id')->unsigned();
                        $table->integer('item_id')->unsigned();
                        $table->integer('price_id')->unsigned();
                        $table->double('return_price', 12, 3);
                        $table->double('loss_per_item', 12, 3);
                        $table->integer('quantity');
                        $table->double('amount', 12, 3);

                        $table->integer('status')->default(1)->comment('0=Inactive, 1=Active');
                        $table->integer('year');
                        $table->integer('created_by')->unsigned();
                        $table->integer('updated_by')->nullable()->unsigned();
			$table->timestamps();
		});
                Schema::table('PurchaseRToSuppliers', function(Blueprint $table)
                {
                    $table->index('i_sup_return_id');
                    $table->foreign('sup_r_invoice_id')->references('sup_r_invoice_id')->on('SupplierReturnInvoices')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('item_id')->references('item_id')->on('ItemInfos')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('price_id')->references('price_id')->on('PriceInfos')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('created_by')->references('emp_id')->on('EmpInfos')->onDelete('cascade')->onUpdate('CASCADE');
                    $table->foreign('updated_by')->references('emp_id')->on('EmpInfos')->onDelete('cascade')->onUpdate('CASCADE');
                });
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('PurchaseRToSuppliers');
	}

}
